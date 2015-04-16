1. key rotation --> only rotate if key is valid (UI class)
2. date offsets --> only offset if date is valid (UI class)

# encryptor
3. run
  encrypts message
  needs key
  needs offset
  returns encrypted message
4. code (encrypt/decrypt)
5. crack
6. user_interface
  reads args from command line
  opens files and saves to attrs that are accessible
  calls Encryption class to encrypt message (pass in message, key, date)
  gets result and writes to new decrypt file

7. character_map

run (break encryptor class apart)
