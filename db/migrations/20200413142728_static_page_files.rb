Sequel.migration do
  up do
    create_table :static_page_files do
      primary_key :id, type: :Bignum

      foreign_key :base_page_id, :static_pages, index: true
      foreign_key :translator_id, :clients, index: true
      String :language, null: false, index: true, default: 'en', size: 6
      String :scriptlanguage, null: false, index: true, default: 'markdown', size: 24
      String :status, size: 32, index: true, null: false

      column :created_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
      column :updated_at, DateTime, null: false, index: true, default: Sequel.lit("now()")
    end
    run <<~EUP
      DO $$
      BEGIN
        --triggers
        IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'static_page_files_update_timestamp') THEN
          CREATE TRIGGER static_page_files_update_timestamp 
            BEFORE INSERT OR UPDATE ON static_page_files
            FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
        END IF;
      END $$;
    EUP
  end
  down { run 'DROP TABLE static_page_files CASCADE' }
end
