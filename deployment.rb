class Deployment < Sequel::Model
  DB.create_table? :deployments do
    primary_key :id
    string :application_name
    string :account_name
    text :changelog
    text :description
    number :revision
    string :deployed_by
    string :created_at
    string :version
  end
end
