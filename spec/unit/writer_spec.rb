RSpec.describe Mysqlexport::Writer do
  let(:options) { DB_INFO.clone }
  let(:writer) { Mysqlexport::Writer.new options }

  it "returns path with tablename when path is a dir and table option given" do
    path = Dir.pwd.to_s
    options[:table] = "test"
    expect(writer.filter_path(path)).to eq("#{Dir.pwd}/#{options[:table]}.csv")
  end

  it "returns path with timestamp when path is a dir and table option not given" do
    path = Dir.pwd.to_s
    options.delete(:table)
    options[:execute] = "test"
    filtered_path = writer.filter_path(path)
    expect(filtered_path[-26..]).to match("^[0-9]{10}_mysqlexport.csv$")
  end

  it "returns path with filename when path is a file and table option given" do
    path = "#{Dir.pwd}/file.txt"
    options[:table] = "table"
    expect(writer.filter_path(path)).to eq(path)
  end

  it "returns path with filename when path is a file and table option not given" do
    path = "#{Dir.pwd}/file.txt"
    options.delete(:table)
    options[:execute] = "test"
    expect(writer.filter_path(path)).to eq(path)
  end

  it "returns current directory with tablename when path not given and table option given" do
    path = nil
    options[:table] = "table"
    expect(writer.filter_path(path)).to eq("#{Dir.pwd}/#{options[:table]}.csv")
  end

  it "returns current directory with timestamp when path not given and table option given" do
    path = nil
    options.delete(:table)
    options[:execute] = "test"
    filtered_path = writer.filter_path(path)
    expect(filtered_path[0..-28]).to eq(Dir.pwd.to_s)
    expect(filtered_path[-26..]).to match("^[0-9]{10}_mysqlexport.csv$")
  end

  it "cannot create write object when table and execute both are not present" do
    options.delete(:table)
    expect { Mysqlexport::Writer.new(options) }.to raise_error(::Mysqlexport::Error)
  end
end
