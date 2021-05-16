RSpec.describe Mysqlexport::Json do
  let(:options) { DB_INFO.clone }

  it "cannot create json object without table or execute options" do
    options.delete(:table)
    expect { Mysqlexport::Json.new(options) }.to raise_error(::Mysqlexport::Error)
  end

  it "can create json object with only table option" do
    expect(Mysqlexport::Json.new(options).class).to eq(::Mysqlexport::Json)
  end

  it "can create json object with only execute option" do
    options.delete(:table)
    options[:execute] = "test"
    expect(Mysqlexport::Json.new(options).class).to eq(::Mysqlexport::Json)
  end

  it "can create json object with both table and execute options" do
    options[:execute] = "test"
    expect(Mysqlexport::Json.new(options).class).to eq(::Mysqlexport::Json)
  end

  it "can write in file with contents" do
    options[:execute] = "select `first_name`,`last_name`,`birth_date` from `#{options[:table]}` limit 2"
    FakeFS.with_fresh do
      ::Mysqlexport::Json.new(options).to_path("test.json")
      expect(File.read("test.json")).to eq("[{\"first_name\":\"Georgi\",\"last_name\":\"Facello\",\"birth_date\":\"1986-06-26\"},{\"first_name\":\"Bezalel\",\"last_name\":\"Simmel\",\"birth_date\":\"1985-11-21\"}]")
    end
  end

  it "can write to string" do
    options[:execute] = "select `first_name`,`last_name`,`birth_date` from `#{options[:table]}` limit 2"
    expect(::Mysqlexport::Json.new(options).to_s).to eq("[{\"first_name\":\"Georgi\",\"last_name\":\"Facello\",\"birth_date\":\"1986-06-26\"},{\"first_name\":\"Bezalel\",\"last_name\":\"Simmel\",\"birth_date\":\"1985-11-21\"}]")
  end
end
