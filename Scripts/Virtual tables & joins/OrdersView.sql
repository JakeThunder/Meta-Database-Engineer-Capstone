CREATE VIEW `OrdersView` AS
    SELECT 
        order_id, quantity, total_cost
    FROM
        orders
	Where
    quantity > 2;