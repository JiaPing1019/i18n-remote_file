# frozen_string_literal: true

module I18nHelper
  def locales_dir
    'tmp' 
  end

  def base_url
    'http://localhost:8080' 
  end

  def test_de_body
    <<~TXT
      de:
        foo:
          bar:
            hello: Hallo
    TXT
  end

  def test_fr_body
    <<~TXT
      fr:
        foo:
          bar:
            hello: Bonjour
    TXT
  end

  def test_en_body
    <<~TXT
      en:
        foo:
          bar:
            hello: Hello
    TXT
  end
end
