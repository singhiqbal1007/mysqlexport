RSpec.describe Mysqlexport::Config do
  let(:options) { DB_INFO.clone }

  it "can create connection" do
    expect(Mysqlexport::Config.new(options).client.class).to eq(::Mysql2::Client)
  end

  it "return correct value for force_quotes" do
    options["force_quotes"] = "true"
    expect(Mysqlexport::Config.new(options).force_quotes.class).to eq(TrueClass)
    options["force_quotes"] = true
    expect(Mysqlexport::Config.new(options).force_quotes.class).to eq(TrueClass)
    options["force_quotes"] = false
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options["force_quotes"] = "false"
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options["force_quotes"] = "string"
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options["force_quotes"] = nil
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
  end

  it "select entire table when execute is not present" do
    options["table"] = "test"
    expect(Mysqlexport::Config.new(options).execute).to eq("select * from test")
  end

  it "ignore table when execute is present" do
    options["table"] = "test"
    options["execute"] = "select ename from table"
    expect(Mysqlexport::Config.new(options).execute).to eq("select ename from table")
  end
end
