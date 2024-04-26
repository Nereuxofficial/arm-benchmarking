use goose::prelude::*;
use serde::{Deserialize, Serialize};

#[tokio::main]
async fn main() -> Result<(), GooseError> {
    GooseAttack::initialize()?
        .register_scenario(scenario!("LoadtestTransactions")
            .register_transaction(transaction!(loadtest_index))
            .register_transaction(transaction!(loadtest_folder))
            .register_transaction(transaction!(loadtest_create_user))
        )
        .execute()
        .await?;

    Ok(())
}
#[derive(Deserialize, Serialize)]
struct CreateUser {
    username: String,
}

async fn loadtest_create_user(user: &mut GooseUser) -> TransactionResult {
    let body = CreateUser {
        username: "test".to_string(),
    };
    let _goose_metrics = user.post_json("/users", &body).await?;

    Ok(())
}

async fn loadtest_folder(user: &mut GooseUser) -> TransactionResult {
    let paths = vec!["/assets/index.html", "/assets/style.css"];
    for path in paths {
        let _goose_metrics = user.get(path).await?;
    }

    Ok(())
}


async fn loadtest_index(user: &mut GooseUser) -> TransactionResult {
    let _goose_metrics = user.get("").await?;

    Ok(())
}