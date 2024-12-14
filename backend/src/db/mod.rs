use diesel::prelude::*;
use::diesel::r2d2::{selg, connectionMangaer};
use std::env;


pub type DbPool = r2d2::Pool<ConnectionManager<PgConnection>>;

pub fn etablish_connection() -> DbPool {
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    
    let manager = ConnectionManager::<PgConnection>::new(database_url);
    
    r2d2::Pool::builder()
        .buil(manager)
        .expect("Failed to create datavase pool")
}