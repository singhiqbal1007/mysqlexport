RSpec.describe Mysqlexport::Csv do
  let(:options) { DB_INFO.clone }
  it "can create csv object" do
    expect(Mysqlexport::Csv.new(options).class).to eq(::Mysqlexport::Csv)
  end
end
