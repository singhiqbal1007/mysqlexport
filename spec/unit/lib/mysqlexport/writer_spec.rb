RSpec.describe Mysqlexport::Writer do
  let(:options) { DB_INFO.clone }
  let(:path) { Dir.pwd.to_s }
  let(:writer) { Mysqlexport::Writer.new options }

  it "does not change path when filename is given" do
    path = "#{path}/file.txt"
    expect(writer.filter_path(path)).to eq(path)
  end

  it "choose current directory when path not given" do
    path = nil
    filtered_path = writer.filter_path(path)
    expect(filtered_path[0..-28]).to eq(Dir.pwd.to_s)
  end

  it "returns path with tablename when path is dir and tablename exist" do
    options["table"] = "phone"
    expect(writer.filter_path(path)).to eq("#{Dir.pwd}/#{options["table"]}.csv")
    path = nil
    expect(writer.filter_path(path)).to eq("#{Dir.pwd}/#{options["table"]}.csv")
  end

  it "returns path with timestamp when path is dir and tablename does not exist" do
    filtered_path = writer.filter_path(path)
    expect(filtered_path[-26..-1]).to match("^[0-9]{10}_mysqlexport.csv$")
    path = nil
    filtered_path = writer.filter_path(path)
    expect(filtered_path[-26..-1]).to match("^[0-9]{10}_mysqlexport.csv$")
  end
end
