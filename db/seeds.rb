Category.create([
    { name: "夜におすすめ" },
    { name: "昼におすすめ" },
    { name: "ライダーカフェ"},
    { name: "近くにガソリンスタンド有"},
    { name: "近くに飲食店有"},
    { name: "バイク可駐車場有"},
    { name: "オーシャンビュー"}
])

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/千葉フォルニア.jpg"),
    place_name: '千葉県',
    area: '千葉フォルニア',
    street_address: '千葉県袖ケ浦市南袖',
    regular_holiday: '日曜日',
    url: 'https://www.roadvel.com/',
    user_id: '1',
    station: '袖ヶ浦駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/BOBBY.jpg"),
    place_name: '栃木県',
    area: 'BOBBY',
    street_address: '栃木県那須塩原市井口５４８',
    regular_holiday: '日曜日',
    time: '9:00~',
    url: 'https://www.roadvel.com/',
    user_id: '1',
    station: '西遅沢駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/牛久大仏.jpg"),
    place_name: '茨城県',
    area: '牛久大仏',
    street_address: '茨城県牛久市久野町2083',
    time: '9:30~',
    url: 'https://www.roadvel.com/',
    user_id: '1',
    station: '牛久駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/いろは坂.jpg"),
    place_name: '栃木県',
    area: 'いろは坂',
    street_address: '栃木県日光市細尾町国道120号線',
    time: '9:30~',
    url: 'https://www.roadvel.com/',
    user_id: '1',
    station: '東武日光駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/原岡海岸.jpg"),
    place_name: '千葉県',
    area: '原岡海水浴場',
    street_address: '千葉県南房総市富浦町原岡210-1',
    time: '9:30~',
    url: 'https://www.roadvel.com/',
    user_id: '2',
    station: '富浦駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/上信越高原国立公園.jpg"),
    place_name: '長野県',
    area: '上信越高原国立公園',
    street_address: '群馬県吾妻郡中之条町',
    url: 'https://www.env.go.jp/park/joshinetsu/',
    user_id: '2',
    station: '上条駅'
)

Post.create(
    post_photo: open("#{Rails.root}/db/fixtures/ツーリングポイント.jpg"),
    place_name: '東京都',
    area: 'ツーリングポイント',
    street_address: '東京都足立区保木間4-50-13',
    url: 'https://abk5.tumabeni.com/coffee/',
    time: '9:00~',
    regular_holiday: '日曜日',
    user_id: '2',
    station: '谷塚駅'
)
