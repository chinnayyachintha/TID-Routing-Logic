def lambda_handler(event, context):
    # Extract input values from the event
    currency = event.get("currency")
    channel = event.get("channel")

    # Define the Terminal IDs for each case
    terminal_ids = {
        ("CAD", "Direct"): "0089250008025557433284",    # Flair Airlines Ecommerce CAD
        ("CAD", "Indirect"): "0089250008025557441121",  # Flair Airlines MOTO CAD
        ("USD", "Direct"): "0017340008025557375191",    # Flair Airlines Ecommerce USD
        ("USD", "Indirect"): "0017340008025557391040"   # Flair Airlines MOTO USD
    }

    # Find the Terminal ID based on the currency and channel input
    tid = terminal_ids.get((currency, channel))

    # Check if TID was found; if not, return an error message
    if tid:
        return {
            "statusCode": 200,
            "body": {
                "message": "Terminal ID found",
                "currency": currency,
                "channel": channel,
                "terminal_id": tid
            }
        }
    else:
        return {
            "statusCode": 400,
            "body": {
                "message": "Invalid input: No matching Terminal ID",
                "currency": currency,
                "channel": channel
            }
        }
