Sequel.migration do
  
  up do
    run <<~EUP0
      CREATE TYPE tag_group_type AS ENUM ('client', 'file', 'article', 'message');
    EUP0
    create_table :tagnames do
      primary_key :id, type: :Bignum
      String :tagname, size: 64, index: true, unique: true
      column :taggroup, :tag_group_type, index: true
      DateTime :created_at, null: false, index: true, default: Sequel.lit("now()")
    end
    run <<~EUP1
      INSERT INTO tagnames ( tagname, taggroup )
        VALUES ( 'admin', 'client' ), ( 'author', 'client' ), ( 'moderator', 'client' ), ( 'spammer', 'client' )
        ON CONFLICT DO NOTHING;
    EUP1
  end
  down do 
    run <<~EDOWN
      DROP TABLE tagnames CASCADE;
      DROP TYPE IF EXISTS tag_group_type;
    EDOWN
  end

end
