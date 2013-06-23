module ApplicationHelper

  def full_title(page_title)
    base_title = "app/helpers/application_helper.rb"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def decrypt(message)
    encryption_key = 'IQPRZUDGWWCGVGHTKHRPEQAYPPAQXASH'
    decrypted_message = AESCrypt.decrypt(message, encryption_key)
  end
end

