#[derive(Copy, Drop, Serde, IntrospectPacked)]
#[dojo::model]
struct Game {
    #[key]
    id: u32,
    short_name: felt252,
    full_name: felt252,
    rom_path: felt252,
    owner: felt252,
}
