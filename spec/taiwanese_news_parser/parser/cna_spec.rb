require 'spec_helper'

describe TaiwaneseNewsParser::Parser::Cna do
  describe '#parse' do
    it do
      url = 'http://www.cna.com.tw/News/FirstNews/201306290064-1.aspx'
      FakeWeb.register_uri(:get, url, body:sample(__FILE__,'cna_s1.html'))
      article = described_class.new(url).parse
      article[:title].should == '電競亞室運 中華隊奪牌希望濃'
      article[:content].should include('中華代表隊選手楊家正（Sen），今天在韓國仁川進行的2013亞洲室內暨武藝運動會中的電競比賽「星海爭霸II」預賽')
      article[:company_name].should == '中央社'
      #TODO article[:reporter_name].should == '姜遠珍'
      article[:published_at].should == Time.new(2013,6,29,19,3)
    end
  end

  describe '#parse_url_id' do
    it 'hanle different versions of same news' do
      url = 'http://www.cna.com.tw/News/FirstNews/201308140023.aspx'
      described_class.parse_url_id(url).should == '201308140023'

      url = 'http://www.cna.com.tw/News/FirstNews/201308160018-1.aspx'
      described_class.parse_url_id(url).should == '201308160018'

      url = 'http://www.cna.com.tw/News/FirstNews/201308110023-3.aspx'
      described_class.parse_url_id(url).should == '201308110023'
    end
    it 'handle grouped news url' do
      url = 'http://www.cna.com.tw/Topic/Popular/3912-1/201308140022-1.aspx'
      described_class.parse_url_id(url).should == '201308140022'
    end
  end
end
