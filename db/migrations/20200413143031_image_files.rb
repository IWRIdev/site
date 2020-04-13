Sequel.migration do
  up do
    create_table :image_files do
      primary_key :id, type: :Bignum

      foreign_key :owner_id, :clients, index: true
      column :image_data, :jsonb
      column :status, String, size: 32, index: true, null: false

      column :created_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
      column :updated_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
    end
    run <<~EUP
      DO $$
      BEGIN
        --triggers
        IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'image_files_update_timestamp') THEN
          CREATE TRIGGER image_files_update_timestamp 
            BEFORE INSERT OR UPDATE ON image_files
            FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
        END IF;
      END $$;
    EUP
  end
  down { run 'DROP TABLE image_files CASCADE' }
end
