require 'csv_reader/row_parser'
require 'csv'

RSpec.describe RowParser do

  context '#call' do
    let(:row) { CSV::Row.new(['Timestamp','Address','ZIP','FullName','FooDuration','BarDuration','TotalDuration','Notes'], ['4/1/11 11:00:00 AM',"123 4th St, Anywhere, AA",'94121','Monkey Alberto','1:23:32.123','1:32:33.123','zzsasdfa','I am the very model of a modern major general']) }
    let(:bad_row) {CSV::Row.new(['Timestamp','Address','ZIP','FullName','FooDuration','BarDuration','TotalDuration','Notes'], ['x/x/xx xx:xx:xx AM',"123 4th St, Anywhere, AA",'94121','Monkey Alberto','1:23:32.123','1:32:33.123','zzsasdfa','I am the very model of a modern major general'])}

    it 'should return a CSV row' do
      expect(described_class.call(row)).to be_a CSV::Row
    end

    it 'should return nil if unparsable' do
      expect(described_class.call(bad_row)).to be nil
    end
  end

  context '#timestamp' do
    let(:time_string) { '2/29/16 12:11:11 PM' }
    it 'should be formatted in ISO-8601 and converted from PST to EST' do
      expect(described_class.timestamp(time_string)).to eq '2016-02-29T15:11:11-05:00'
    end
  end

  context '#zipcode' do
    it 'should add a 0 prefix if there are fewer than 5 digits' do
      expect(described_class.zipcode('2144')).to eq '02144'
    end
  end

  context '#name' do
    it 'should convert to uppercase' do
      expect(described_class.name('Evangeline')).to eq 'EVANGELINE'
    end
  end

  context '#time_to_seconds' do
    it 'should convert HH:MM:SS.MS time to a floating point seconds format' do
      expect(described_class.time_to_seconds('1:23:32.123')).to eq 5012.123
    end
  end

  # context '#unicode_validator' do
  #   it 'should replace invalid UTF-8 characters with Unicode Replacement Characters'
  # end
end
