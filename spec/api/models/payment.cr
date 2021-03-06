# initialize models
crystal_model(
  Payment,
  id : (Int32 | Nil) = nil,
  amount : (Int32 | Nil) = nil,
  created_at : (Time | Nil) = Time.now,
  payment_type : (String | Nil) = "incoming_draft",
  user_id : (Int32 | Nil) = nil,
  destination_user_id : (Int32 | Nil) = nil,
)
crystal_resource(payment, payments, Payment)

crystal_migrate_payment
crystal_clear_table_payment

struct Payment
  TYPE_INCOMING = "incoming"
  TYPE_OUTGOING = "outgoing"
  TYPE_TRANSFER = "transfer"
end
