from cryptography.fernet import Fernet
import json

# Function to encrypt a JSON file using AES encryption
def encrypt_json_file(input_file, output_file, key):
    # Read JSON data from input file
    with open(input_file, 'r') as file:
        json_data = file.read()

    # Serialize JSON data
    serialized_data = json_data.encode()

    # Create an AES cipher instance with the key
    cipher = Fernet(key)

    # Encrypt the serialized JSON data
    encrypted_data = cipher.encrypt(serialized_data)

    # Write the encrypted data to the output file
    with open(output_file, 'wb') as file:
        file.write(encrypted_data)

# Sample JSON data
data = {
    "name": "Alice",
    "age": 30,
    "city": "Wonderland"
}

# Input and output file paths
input_file = 'input.json'
output_file = 'encrypted.json'

# Generate a key (for demonstration purposes; use a secure method to generate a key in production)
key = Fernet.generate_key()

# Write JSON data to input file
with open(input_file, 'w') as file:
    json.dump(data, file)

# Encrypt JSON file
encrypt_json_file(input_file, output_file, key)

print("JSON file encrypted successfully.")