Sequel.migration do
  up do
    create_table :clients do
      primary_key :id, type: :Bignum
      column :email, String, size: 128, index: true, unique: true
      column :phone, :Bigint, index: true, unique: true # 20 digits in ITU, country first
      column :password_hash, String, size: 256
      column :username, String, size: 128, index: true, unique: true

      column :login_count, :Bigint, null: false, default: 0
      column :tags, 'varchar(64)[]', default: '{}'

      column :created_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
      column :updated_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
    end
    run <<~EUP
      COMMENT ON COLUMN clients.phone IS 'up to 20 digits by ITU, country first';

      CREATE OR REPLACE FUNCTION check_client_tag() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        NEW.tags := ARRAY( SELECT DISTINCT i FROM unnest( NEW.tags ) );
        IF ! NEW.tags <@ ( SELECT array_agg( tagname ) FROM tagnames ) THEN
          RAISE foreign_key_violation USING MESSAGE = 'Nonexistent tag names';
        END IF;
        RETURN NEW;
      END $$;

      CREATE OR REPLACE FUNCTION check_client_reqs() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        IF NEW.email IS NULL AND NEW.phone IS NULL THEN
          RAISE foreign_key_violation USING MESSAGE = 'Client must have valid phone or email filled.';
        END IF;
        RETURN NEW;
      END $$;

      DO $$
      BEGIN
        --triggers
        IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'clients_update_timestamp') THEN
          CREATE TRIGGER clients_update_timestamp 
            BEFORE INSERT OR UPDATE ON clients
            FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'clients_check_tag') THEN
          CREATE TRIGGER clients_check_tag 
            BEFORE INSERT OR UPDATE OF tags ON clients
            FOR EACH ROW EXECUTE PROCEDURE check_client_tag();
        END IF;

      END $$;
    EUP
  end
  down do
    run <<~EDOWN
      DROP TABLE clients CASCADE;
      DROP FUNCTION check_client_tag CASCADE;
    EDOWN
  end
end
