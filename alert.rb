class Alert < Sequel::Model
  DB.create_table? :alerts do
    primary_key :id
    String :application_name
    String :account_name
    String :severity
    String :message
    String :short_description
    String :long_description
    String :alert_url
    String :created_at
    String :version
  end
end
