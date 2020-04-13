Sequel.migration do
  up do
    create_table :static_pages do
      primary_key :id, type: :Integer
      
      String :title, size: 128, null: false, index: true, unique: true
      String :shorturl, size: 128, unique: true

      foreign_key :parent_id, :static_pages, index: true
      Integer :menu_order, null: false

      foreign_key :author_id, :clients, index: true

      DateTime :created_at, null: false, index: true, default: Sequel.lit("now()")
      DateTime :updated_at, null: false, index: true, default: Sequel.lit("now()")
    end
    run <<~EUP
      DO $$
      BEGIN
        --triggers
        IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'static_pages_update_timestamp') THEN
          CREATE TRIGGER static_pages_update_timestamp 
            BEFORE INSERT OR UPDATE ON static_pages
            FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
        END IF;
      END $$;
    EUP
  end
  down { run 'DROP TABLE static_pages CASCADE' }
end
