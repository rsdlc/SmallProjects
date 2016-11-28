class Url < ActiveRecord::Base
  belongs_to :user
  validates :long_url, :format => URI::regexp(%w(http https))
  validates :long_url, uniqueness: true
  before_create :shortenurl
  @@contador = 0

  def shortenurl
    @@randomletter = ('a'..'z').to_a.shuffle[0..2].join("")
    self.short_url = @@contador.to_s + @@randomletter
    @@contador = @@contador + 1   
  end

  def nuevourl
    @nuevourl=self[:long_url]
    self.click_count = self.click_count + 1
    self.save
    @nuevourl
  end


end