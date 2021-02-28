RSpec.describe Mysqlexport do
  let(:options) { DB_INFO.clone }

  it "has a version number" do
    expect(Mysqlexport::VERSION).not_to be nil
  end

  it "can create csv object" do
    expect(Mysqlexport::Csv.new(options).class).to eq(::Mysqlexport::Csv)
  end
end
