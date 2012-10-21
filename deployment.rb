class Deployment < Sequel::Model
  DB.create_table? :deployments do
    primary_key :id
    String :application_name
    String :account_name
    String :changelog
    String :description
    Numeric :revision
    String :deployed_by
    DateTime :created_at
    String :version
  end
end
