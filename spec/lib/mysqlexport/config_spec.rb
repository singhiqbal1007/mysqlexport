RSpec.describe Mysqlexport::Config do
  let(:config) { Mysqlexport::Config.new({ username: "root", password: "", database: "test", query: "select * from employees"}) }

  it "can create connection" do
    expect(config.client.class).to eq(::Mysql2::Client)
  end
end
