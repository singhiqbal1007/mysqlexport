RSpec.describe Mysqlexport::Config do
  let(:config) { Mysqlexport::Config.new(DB_INFO) }

  it "can create connection" do
    expect(config.client.class).to eq(::Mysql2::Client)
  end
end
