mod store;

mod models {
    mod index;
    mod game;
}

mod components {
    mod initializable;
    mod registerable;
}

mod systems {
    mod actions;
}

#[cfg(test)]
mod tests {
    mod setup;
    mod test_world;
}
