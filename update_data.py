# Re-importing the data and previous code context to correct the error after session reset
import pandas as pd
import numpy as np
from datetime import timedelta, datetime

# Load the data
file_path = './ECommerce_consumer behaviour.csv'
data = pd.read_csv(file_path)

# Function to generate a realistic price based on department
def generate_product_price(department):
    # Define typical price ranges for each department
    price_ranges = {
        "pantry": (2, 20),
        "dairy eggs": (1.5, 10),
        "produce": (0.5, 15),
        "beverages": (1, 8),
        "meat seafood": (5, 25),
        "bakery": (1, 12),
        "frozen": (2, 15),
        "snacks": (1, 10),
        "household": (3, 20),
        "personal care": (2, 25)
    }
    low, high = price_ranges.get(department, (1, 20))  # Default range if not found
    return round(np.random.uniform(low, high), 2)

# Function to generate realistic quantities
def generate_quantity():
    return np.random.choice([1, 2, 3, 4, 5], p=[0.5, 0.3, 0.1, 0.05, 0.05])

# Initialize starting date for 2023
start_date = datetime(2023, 1, 1)

# Create a column for order_date by user_id and order_id
data['order_date'] = np.nan

# Dictionary to store the last order date per user to respect the 'days_since_prior_order'
last_order_date = {}

for index, row in data.iterrows():
    user_id = row['user_id']
    order_number = row['order_number']
    
    if pd.isna(row['days_since_prior_order']) or order_number == 1:
        # If it's the user's first order or days_since_prior_order is NaN, start in 2023
        order_date = start_date + timedelta(days=np.random.randint(0, 31))  # Random date in January 2023
    else:
        # Add days since the last order to the last known order date for this user
        prior_order_date = last_order_date.get(user_id, start_date)
        order_date = prior_order_date + timedelta(days=row['days_since_prior_order'])
    
    # Save the generated order date
    data.at[index, 'order_date'] = order_date
    last_order_date[user_id] = order_date  # Update the last order date for this user

# Generate realistic product prices and quantities
data['product_price'] = data['department'].apply(generate_product_price)
data['quantity'] = data['product_name'].apply(lambda x: generate_quantity())

# Save the updated DataFrame to a CSV file
output_file = './Updated_ECommerce_data.csv'
data.to_csv(output_file, index=False)

output_file
