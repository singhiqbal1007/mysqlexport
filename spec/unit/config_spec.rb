RSpec.describe Mysqlexport::Config do
  let(:options) { DB_INFO.clone }

  it "can create connection" do
    expect(Mysqlexport::Config.new(options).client.class).to eq(::Mysql2::Client)
  end

  it "return correct value for force_quotes option" do
    options[:force_quotes] = "true"
    expect(Mysqlexport::Config.new(options).force_quotes.class).to eq(TrueClass)
    options[:force_quotes] = true
    expect(Mysqlexport::Config.new(options).force_quotes.class).to eq(TrueClass)
    options[:force_quotes] = false
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options[:force_quotes] = "false"
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options[:force_quotes] = "string"
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
    options[:force_quotes] = nil
    expect(Mysqlexport::Config.new(options).force_quotes).to be_nil
  end

  it "return correct value for csv_heading option" do
    options[:csv_heading] = "true"
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(TrueClass)
    options[:csv_heading] = true
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(TrueClass)
    options[:csv_heading] = false
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(FalseClass)
    options[:csv_heading] = "false"
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(FalseClass)
    options[:csv_heading] = "string"
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(TrueClass)
    options[:csv_heading] = nil
    expect(Mysqlexport::Config.new(options).csv_heading.class).to eq(TrueClass)
  end

  it "return correct value for pretty option" do
    options[:pretty] = "true"
    expect(Mysqlexport::Config.new(options).pretty.class).to eq(TrueClass)
    options[:pretty] = true
    expect(Mysqlexport::Config.new(options).pretty.class).to eq(TrueClass)
    options[:pretty] = false
    expect(Mysqlexport::Config.new(options).pretty).to be_nil
    options[:pretty] = "false"
    expect(Mysqlexport::Config.new(options).pretty).to be_nil
    options[:pretty] = "string"
    expect(Mysqlexport::Config.new(options).pretty).to be_nil
    options[:pretty] = nil
    expect(Mysqlexport::Config.new(options).pretty).to be_nil
  end

  it "select entire table when execute is not present" do
    expect(Mysqlexport::Config.new(options).execute).to eq("select * from #{options[:table]}")
  end

  it "ignore table when execute is present" do
    options[:execute] = "select ename from table"
    expect(Mysqlexport::Config.new(options).execute).to eq("select ename from table")
  end

  it "selects execute when table not present" do
    options.delete(:table)
    options[:execute] = "select ename from table"
    expect(Mysqlexport::Config.new(options).execute).to eq("select ename from table")
  end
end
