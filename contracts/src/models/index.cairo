#[derive(Clone, Drop, Serde)]
#[dojo::model]
struct Game {
    #[key]
    id: u64,
    name: felt252,
    desc: ByteArray,
    image: ByteArray,
    rating: u8,
    releasedate: u64,
    developer: felt252,
    publisher: felt252,
    genre: felt252,
    players: u8,
    playcount: u32,
    lastplayed: u64,
    owner: felt252,
}
