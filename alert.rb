class Alert < Sequel::Model
  DB.create_table? :alerts do
    primary_key :id
    string :application_name
    string :account_name
    text :severity
    text :message
    text :short_description
    text :long_description
    string :alert_url
    string :created_at
    string :version
  end
end
