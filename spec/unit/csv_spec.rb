RSpec.describe Mysqlexport::Csv do
  let(:options) { DB_INFO.clone }

  it "cannot create csv object without table or execute options" do
    options.delete(:table)
    expect { Mysqlexport::Csv.new(options) }.to raise_error(::Mysqlexport::Error)
  end

  it "can create csv object with only table option" do
    expect(Mysqlexport::Csv.new(options).class).to eq(::Mysqlexport::Csv)
  end

  it "can create csv object with only execute option" do
    options.delete(:table)
    options[:execute] = "test"
    expect(Mysqlexport::Csv.new(options).class).to eq(::Mysqlexport::Csv)
  end

  it "can create csv object with both table and execute options" do
    options[:execute] = "test"
    expect(Mysqlexport::Csv.new(options).class).to eq(::Mysqlexport::Csv)
  end

  it "can write to string" do
    options[:execute] = "select `first_name`,`last_name`,`birth_date` from `#{options[:table]}` limit 2"
    expect(::Mysqlexport::Csv.new(options).to_s).to eq("first_name,last_name,birth_date\nGeorgi,Facello,1986-06-26\nBezalel,Simmel,1985-11-21\n")
  end

  it "can write in file with contents" do
    options[:execute] = "select `first_name`,`last_name`,`birth_date` from `#{options[:table]}` limit 2"
    FakeFS.with_fresh do
      ::Mysqlexport::Csv.new(options).to_path("test.csv")
      expect(File.read("test.csv")).to eq("first_name,last_name,birth_date\nGeorgi,Facello,1986-06-26\nBezalel,Simmel,1985-11-21\n")
    end
  end

  it "tests force_quotes option" do
    options[:execute] = "select * from `#{options[:table]}` limit 2"
    options[:force_quotes] = true
    FakeFS.with_fresh do
      ::Mysqlexport::Csv.new(options).to_path("test.csv")
      expect(File.read("test.csv")).to eq("\"first_name\",\"last_name\",\"birth_date\"\n\"Georgi\",\"Facello\",\"1986-06-26\"\n\"Bezalel\",\"Simmel\",\"1985-11-21\"\n")
    end
  end

  it "tests col_sep option" do
    options[:execute] = "select * from `#{options[:table]}` limit 2"
    options[:col_sep] = ";"
    FakeFS.with_fresh do
      ::Mysqlexport::Csv.new(options).to_path("test.csv")
      expect(File.read("test.csv")).to eq("first_name;last_name;birth_date\nGeorgi;Facello;1986-06-26\nBezalel;Simmel;1985-11-21\n")
    end
  end

  it "tests row_sep option" do
    options[:execute] = "select * from `#{options[:table]}` limit 2"
    options[:row_sep] = ";"
    FakeFS.with_fresh do
      ::Mysqlexport::Csv.new(options).to_path("test.csv")
      expect(File.read("test.csv")).to eq("first_name,last_name,birth_date;Georgi,Facello,1986-06-26;Bezalel,Simmel,1985-11-21;")
    end
  end

  it "tests csv_heading option" do
    options[:execute] = "select * from `#{options[:table]}` limit 2"
    options[:csv_heading] = false
    FakeFS.with_fresh do
      ::Mysqlexport::Csv.new(options).to_path("test.csv")
      expect(File.read("test.csv")).to eq("Georgi,Facello,1986-06-26\nBezalel,Simmel,1985-11-21\n")
    end
  end
end
