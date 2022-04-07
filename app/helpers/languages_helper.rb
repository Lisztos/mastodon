# frozen_string_literal: true

module LanguagesHelper
  ISO_639_1 = {
    aa: %w(Afar Afaraf).freeze,
    ab: ['Abkhaz', 'аҧсуа бызшәа'].freeze,
    ae: %w(Avestan avesta).freeze,
    af: %w(Afrikaans Afrikaans).freeze,
    ak: %w(Akan Akan).freeze,
    am: %w(Amharic አማርኛ).freeze,
    an: %w(Aragonese aragonés).freeze,
    ar: ['Arabic', 'اللغة العربية'].freeze,
    as: %w(Assamese অসমীয়া).freeze,
    av: ['Avaric', 'авар мацӀ'].freeze,
    ay: ['Aymara', 'aymar aru'].freeze,
    az: ['Azerbaijani', 'azərbaycan dili'].freeze,
    ba: ['Bashkir', 'башҡорт теле'].freeze,
    be: ['Belarusian', 'беларуская мова'].freeze,
    bg: ['Bulgarian', 'български език'].freeze,
    bh: %w(Bihari भोजपुरी).freeze,
    bi: %w(Bislama Bislama).freeze,
    bm: %w(Bambara bamanankan).freeze,
    bn: %w(Bengali বাংলা).freeze,
    bo: ['Tibetan', 'བོད་ཡིག'].freeze,
    br: %w(Breton brezhoneg).freeze,
    bs: ['Bosnian', 'bosanski jezik'].freeze,
    ca: %w(Catalan Català).freeze,
    ce: ['Chechen', 'нохчийн мотт'].freeze,
    ch: %w(Chamorro Chamoru).freeze,
    co: %w(Corsican corsu).freeze,
    cr: %w(Cree ᓀᐦᐃᔭᐍᐏᐣ).freeze,
    cs: %w(Czech čeština).freeze,
    cu: ['Old Church Slavonic', 'ѩзыкъ словѣньскъ'].freeze,
    cv: ['Chuvash', 'чӑваш чӗлхи'].freeze,
    cy: %w(Welsh Cymraeg).freeze,
    da: %w(Danish dansk).freeze,
    de: %w(German Deutsch).freeze,
    dv: %w(Divehi Dhivehi).freeze,
    dz: ['Dzongkha', 'རྫོང་ཁ'].freeze,
    ee: %w(Ewe Eʋegbe).freeze,
    el: %w(Greek Ελληνικά).freeze,
    en: %w(English English).freeze,
    eo: %w(Esperanto Esperanto).freeze,
    es: %w(Spanish Español).freeze,
    et: %w(Estonian eesti).freeze,
    eu: %w(Basque euskara).freeze,
    fa: %w(Persian فارسی).freeze,
    ff: %w(Fula Fulfulde).freeze,
    fi: %w(Finnish suomi).freeze,
    fj: %w(Fijian Vakaviti).freeze,
    fo: %w(Faroese føroyskt).freeze,
    fr: %w(French Français).freeze,
    fy: ['Western Frisian', 'Frysk'].freeze,
    ga: %w(Irish Gaeilge).freeze,
    gd: ['Scottish Gaelic', 'Gàidhlig'].freeze,
    gl: %w(Galician galego).freeze,
    gu: %w(Gujarati ગુજરાતી).freeze,
    gv: %w(Manx Gaelg).freeze,
    ha: %w(Hausa هَوُسَ).freeze,
    he: %w(Hebrew עברית).freeze,
    hi: %w(Hindi हिन्दी).freeze,
    ho: ['Hiri Motu', 'Hiri Motu'].freeze,
    hr: %w(Croatian Hrvatski).freeze,
    ht: ['Haitian', 'Kreyòl ayisyen'].freeze,
    hu: %w(Hungarian magyar).freeze,
    hy: %w(Armenian Հայերեն).freeze,
    hz: %w(Herero Otjiherero).freeze,
    ia: %w(Interlingua Interlingua).freeze,
    id: ['Indonesian', 'Bahasa Indonesia'].freeze,
    ie: %w(Interlingue Interlingue).freeze,
    ig: ['Igbo', 'Asụsụ Igbo'].freeze,
    ii: ['Nuosu', 'ꆈꌠ꒿ Nuosuhxop'].freeze,
    ik: %w(Inupiaq Iñupiaq).freeze,
    io: %w(Ido Ido).freeze,
    is: %w(Icelandic Íslenska).freeze,
    it: %w(Italian Italiano).freeze,
    iu: %w(Inuktitut ᐃᓄᒃᑎᑐᑦ).freeze,
    ja: %w(Japanese 日本語).freeze,
    jv: ['Javanese', 'basa Jawa'].freeze,
    ka: %w(Georgian ქართული).freeze,
    kg: %w(Kongo Kikongo).freeze,
    ki: %w(Kikuyu Gĩkũyũ).freeze,
    kj: %w(Kwanyama Kuanyama).freeze,
    kk: ['Kazakh', 'қазақ тілі'].freeze,
    kl: %w(Kalaallisut kalaallisut).freeze,
    km: %w(Khmer ខេមរភាសា).freeze,
    kn: %w(Kannada ಕನ್ನಡ).freeze,
    ko: %w(Korean 한국어).freeze,
    kr: %w(Kanuri Kanuri).freeze,
    ks: %w(Kashmiri कश्मीरी).freeze,
    ku: %w(Kurdish Kurdî).freeze,
    kv: ['Komi', 'коми кыв'].freeze,
    kw: %w(Cornish Kernewek).freeze,
    ky: %w(Kyrgyz Кыргызча).freeze,
    la: %w(Latin latine).freeze,
    lb: %w(Luxembourgish Lëtzebuergesch).freeze,
    lg: %w(Ganda Luganda).freeze,
    li: %w(Limburgish Limburgs).freeze,
    ln: %w(Lingala Lingála).freeze,
    lo: %w(Lao ພາສາ).freeze,
    lt: ['Lithuanian', 'lietuvių kalba'].freeze,
    lu: %w(Luba-Katanga Tshiluba).freeze,
    lv: ['Latvian', 'latviešu valoda'].freeze,
    mg: ['Malagasy', 'fiteny malagasy'].freeze,
    mh: ['Marshallese', 'Kajin M̧ajeļ'].freeze,
    mi: ['Māori', 'te reo Māori'].freeze,
    mk: ['Macedonian', 'македонски јазик'].freeze,
    ml: %w(Malayalam മലയാളം).freeze,
    mn: ['Mongolian', 'Монгол хэл'].freeze,
    mr: %w(Marathi मराठी).freeze,
    ms: ['Malay', 'Bahasa Malaysia'].freeze,
    mt: %w(Maltese Malti).freeze,
    my: %w(Burmese ဗမာစာ).freeze,
    na: ['Nauru', 'Ekakairũ Naoero'].freeze,
    nb: ['Norwegian Bokmål', 'Norsk bokmål'].freeze,
    nd: ['Northern Ndebele', 'isiNdebele'].freeze,
    ne: %w(Nepali नेपाली).freeze,
    ng: %w(Ndonga Owambo).freeze,
    nl: %w(Dutch Nederlands).freeze,
    nn: ['Norwegian Nynorsk', 'Norsk nynorsk'].freeze,
    no: %w(Norwegian Norsk).freeze,
    nr: ['Southern Ndebele', 'isiNdebele'].freeze,
    nv: ['Navajo', 'Diné bizaad'].freeze,
    ny: %w(Chichewa chiCheŵa).freeze,
    oc: %w(Occitan occitan).freeze,
    oj: %w(Ojibwe ᐊᓂᔑᓈᐯᒧᐎᓐ).freeze,
    om: ['Oromo', 'Afaan Oromoo'].freeze,
    or: %w(Oriya ଓଡ଼ିଆ).freeze,
    os: ['Ossetian', 'ирон æвзаг'].freeze,
    pa: %w(Panjabi ਪੰਜਾਬੀ).freeze,
    pi: %w(Pāli पाऴि).freeze,
    pl: %w(Polish Polski).freeze,
    ps: %w(Pashto پښتو).freeze,
    pt: %w(Portuguese Português).freeze,
    qu: ['Quechua', 'Runa Simi'].freeze,
    rm: ['Romansh', 'rumantsch grischun'].freeze,
    rn: %w(Kirundi Ikirundi).freeze,
    ro: %w(Romanian Română).freeze,
    ru: %w(Russian Русский).freeze,
    rw: %w(Kinyarwanda Ikinyarwanda).freeze,
    sa: %w(Sanskrit संस्कृतम्).freeze,
    sc: %w(Sardinian sardu).freeze,
    sd: %w(Sindhi सिन्धी).freeze,
    se: ['Northern Sami', 'Davvisámegiella'].freeze,
    sg: ['Sango', 'yângâ tî sängö'].freeze,
    si: %w(Sinhala සිංහල).freeze,
    sk: %w(Slovak slovenčina).freeze,
    sl: %w(Slovenian slovenščina).freeze,
    sn: %w(Shona chiShona).freeze,
    so: %w(Somali Soomaaliga).freeze,
    sq: %w(Albanian Shqip).freeze,
    sr: ['Serbian', 'српски језик'].freeze,
    ss: %w(Swati SiSwati).freeze,
    st: ['Southern Sotho', 'Sesotho'].freeze,
    su: ['Sundanese', 'Basa Sunda'].freeze,
    sv: %w(Swedish Svenska).freeze,
    sw: %w(Swahili Kiswahili).freeze,
    ta: %w(Tamil தமிழ்).freeze,
    te: %w(Telugu తెలుగు).freeze,
    tg: %w(Tajik тоҷикӣ).freeze,
    th: %w(Thai ไทย).freeze,
    ti: %w(Tigrinya ትግርኛ).freeze,
    tk: %w(Turkmen Türkmen).freeze,
    tl: ['Tagalog', 'Wikang Tagalog'].freeze,
    tn: %w(Tswana Setswana).freeze,
    to: ['Tonga', 'faka Tonga'].freeze,
    tr: %w(Turkish Türkçe).freeze,
    ts: %w(Tsonga Xitsonga).freeze,
    tt: ['Tatar', 'татар теле'].freeze,
    tw: %w(Twi Twi).freeze,
    ty: ['Tahitian', 'Reo Tahiti'].freeze,
    ug: ['Uyghur', 'ئۇيغۇرچە‎'].freeze,
    uk: %w(Ukrainian Українська).freeze,
    ur: %w(Urdu اردو).freeze,
    uz: %w(Uzbek Ўзбек).freeze,
    ve: %w(Venda Tshivenḓa).freeze,
    vi: ['Vietnamese', 'Tiếng Việt'].freeze,
    vo: %w(Volapük Volapük).freeze,
    wa: %w(Walloon walon).freeze,
    wo: %w(Wolof Wollof).freeze,
    xh: %w(Xhosa isiXhosa).freeze,
    yi: %w(Yiddish ייִדיש).freeze,
    yo: %w(Yoruba Yorùbá).freeze,
    za: ['Zhuang', 'Saɯ cueŋƅ'].freeze,
    zh: %w(Chinese 中文).freeze,
    zu: %w(Zulu isiZulu).freeze,
  }.freeze

  ISO_639_3 = {
    ast: %w(Asturian Asturianu).freeze,
    kab: %w(Kabyle Taqbaylit).freeze,
    kmr: ['Northern Kurdish', 'Kurmancî'].freeze,
    zgh: ['Standard Moroccan Tamazight', 'ⵜⴰⵎⴰⵣⵉⵖⵜ'].freeze,
  }.freeze

  SUPPORTED_LOCALES = {}.merge(ISO_639_1).merge(ISO_639_3).freeze

  # For ISO-639-1 and ISO-639-3 language codes, we have their official
  # names, but for some translations, we need the names of the
  # regional variants specifically
  REGIONAL_LOCALE_NAMES = {
    'es-AR': 'Español (Argentina)',
    'es-MX': 'Español (México)',
    'pt-BR': 'Português (Brasil)',
    'pt-PT': 'Português (Portugal)',
    'sr-Latn': 'Srpski (latinica)',
    'zh-CN': '简体中文',
    'zh-HK': '繁體中文（香港）',
    'zh-TW': '繁體中文（臺灣）',
  }.freeze

  def native_locale_name(locale)
    if locale.blank? || locale == 'und'
      I18n.t('generic.none')
    elsif (supported_locale = SUPPORTED_LOCALES[locale.to_sym])
      supported_locale[1]
    elsif (regional_locale = REGIONAL_LOCALE_NAMES[locale.to_sym])
      regional_locale
    else
      locale
    end
  end

  def standard_locale_name(locale)
    if locale.blank?
      I18n.t('generic.none')
    elsif (supported_locale = SUPPORTED_LOCALES[locale.to_sym])
      supported_locale[0]
    else
      locale
    end
  end

  def valid_locale_or_nil(str)
    return if str.blank?

    code, = str.to_s.split(/[_-]/) # Strip out the region from e.g. en_US or ja-JP

    return unless valid_locale?(code)

    code
  end

  def valid_locale?(locale)
    locale.present? && SUPPORTED_LOCALES.key?(locale.to_sym)
  end
end
