module flash_loan_test::flash_loan_module {
    use lending_core::flash_loan::Config;
    use lending_core::pool::Pool;
    use lending_core::storage::{Storage};
    use sui::clock::Clock;
    use sui::balance::destroy_zero;

    entry public fun take_and_repay<CoinType>(pool: &mut Pool<CoinType>, storage: &mut Storage, flashloan_config: &Config, clock: &Clock, ctx: &mut TxContext) {
        let (balance, receipt) = lending_core::lending::flash_loan_with_ctx(flashloan_config, pool, 20, ctx);
        let new_balance = lending_core::lending::flash_repay_with_ctx(clock, storage, pool, receipt, balance, ctx);
        destroy_zero(new_balance);
    }
}
