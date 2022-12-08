#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <oqs/oqs.h>
#include <oqs/kem_kyber.h>
#include <inttypes.h>
#include <sys/stat.h>
#include <Windows.h>
#include "qdbmp/qdbmp.h"
#include "b64/b64.h"
#include <time.h>
#include <sys/types.h>
#include <sys/timeb.h>
#pragma warning(disable : 4996)
#pragma warning(disable : 6386)
#pragma warning(disable : 6262)
#pragma warning(disable : 4996)


int crypt(int kyber_implementation, char* input_file_path, char* encryption_file_path, char* decryption_file_path, int mode) {
	/*
	Kyber Encryption/Decryption Demo
	How to use:
		1 *configure kyber_implementation variable to which kyber implimentation you
		want to use. Options: 'Kyber512', 'Kyber768', 'Kyber1024'

		2 *configure input_file_path variable to the path of file you want to encrypt.
		
		3 *configure encryption_file_path variable to the path of where you want
		the ciphertext output file to be created.

		4 *configure decryption_file_path variable to the path of where you want
		the decrypted output file to be created.

		The current configuration should use Kyber512 to encrypt and decrypt a file
		./input/lotus.kpg to ciphertext file ./Outputs/Encryption/ciphertext.txt",
		and then decrypt the ciphertext file to output file "./Outputs/Decryption/lotus_decrypted.jpg"
	*/

	// Initialize Kyber512 variables
	uint8_t public_key_512[OQS_KEM_kyber_512_length_public_key] = { "" };
	uint8_t secret_key_512[OQS_KEM_kyber_512_length_secret_key] = { "" };
	uint8_t ciphertext_512[OQS_KEM_kyber_512_length_ciphertext] = { "" };

	// Initialize Kyber768 variables
	uint8_t public_key_768[OQS_KEM_kyber_768_length_public_key] = { "" };
	uint8_t secret_key_768[OQS_KEM_kyber_768_length_secret_key] = { "" };
	uint8_t ciphertext_768[OQS_KEM_kyber_768_length_ciphertext] = { "" };

	// Initialize Kyber1024 variables
	uint8_t public_key_1024[OQS_KEM_kyber_1024_length_public_key] = { "" };
	uint8_t secret_key_1024[OQS_KEM_kyber_1024_length_secret_key] = { "" };
	uint8_t ciphertext_1024[OQS_KEM_kyber_1024_length_ciphertext] = { "" };

	// Initialize program variables
	double output[2];
	OQS_STATUS rc;
	FILE* f_input;
	FILE* f_encryption;
	FILE* f_decryption;
	size_t encoded_size;
	uint8_t buffer32[32] = "";
	uint8_t decrypted_message[32] = "";
	uint8_t header[54] = "";
	int start_enc, end_enc;
	int start_dec, end_dec;
	long double difference_enc, difference_dec;
	long long fileSize;
	long long i = 0;
	int k = 0;
	int j = 0;


	/*
	
	Read Input File

	*/
	f_input = fopen(input_file_path, "rb");
	if (!f_input) {
		printf("Invalid file path, file might not exist: %s\nProgram End.\n", input_file_path);
		return 0;
	}
	_fseeki64(f_input, 0, SEEK_END);
	fileSize = _ftelli64(f_input);
	_fseeki64(f_input, 0, SEEK_SET);


	/*
	
	Initialize cipherfile
	
	*/
	size_t cipherfile_512_size = 24 * fileSize;
	size_t cipherfile_768_size = 34 * fileSize;
	size_t cipherfile_1024_size = 49 * fileSize;
	uint8_t *cipherfile_512 = (uint8_t*)calloc(1, cipherfile_512_size);
	uint8_t *cipherfile_768 = (uint8_t*)calloc(1, cipherfile_768_size);
	uint8_t *cipherfile_1024 = (uint8_t*)calloc(1, cipherfile_1024_size);

	/*

	Keygen

	*/
	
	OQS_KEM_kyber_512_keypair(public_key_512, secret_key_512);

	OQS_KEM_kyber_768_keypair(public_key_768, secret_key_768);

	OQS_KEM_kyber_1024_keypair(public_key_1024, secret_key_1024);

	/*
	
	Encryption

	*/
	if (mode == 1) {
		fread(header, 1, 54, f_input);
		f_encryption = fopen(encryption_file_path, "wb+");
		fwrite(header, 54, 1, f_encryption);
		i = 0;
		j = 0;
		start_enc = clock();
		while (i < fileSize - 54) {
			fread(buffer32, 1, 32, f_input);
			if (kyber_implementation == 1) {
				OQS_KEM_kyber_512_encrypt((cipherfile_512+j), buffer32, public_key_512);
				j += 768;
			}
			else if (kyber_implementation == 2) {
				OQS_KEM_kyber_768_encrypt((cipherfile_768+j), buffer32, public_key_768);
				j += 1088;
			}
			else if (kyber_implementation == 3) {
				OQS_KEM_kyber_1024_encrypt((cipherfile_1024+j), buffer32, public_key_1024);
				j += 1568;
			}
			i += 32;
		}
		end_enc = clock();
		/*
		
		Write Encryption to File

		*/
		if (kyber_implementation == 1) {
			fwrite(cipherfile_512, cipherfile_512_size, 1, f_encryption);
		}
		else if (kyber_implementation == 2) {
			fwrite(cipherfile_768, cipherfile_768_size, 1, f_encryption);
		}
		else if (kyber_implementation == 3) {
			fwrite(cipherfile_1024, cipherfile_1024_size, 1, f_encryption);
		}
		fclose(f_input);
		fclose(f_encryption);

		/*

		Decryption

		*/
		
		f_encryption = fopen(encryption_file_path, "rb");
		if (!f_encryption) {
			printf("Invalid file path, file might not exist: %s\nProgram End.\n", encryption_file_path);
			return 0;
		}
		_fseeki64(f_encryption, 0, SEEK_END);
		fileSize = _ftelli64(f_encryption);
		_fseeki64(f_encryption, 0, SEEK_SET);

		fread(header, 1, 54, f_encryption);

		f_decryption = fopen(decryption_file_path, "wb+");
		fwrite(header, 54, 1, f_decryption);
		i = 0;
		start_dec = clock();
		while (i < fileSize - 54) {
			for (k = 0; k < 32; k++) buffer32[k] = 0x0;
			if (kyber_implementation == 1) {
				for (k = 0; k < OQS_KEM_kyber_512_length_ciphertext; k++) ciphertext_512[k] = 0x0;
				fread(ciphertext_512, 1, OQS_KEM_kyber_512_length_ciphertext, f_encryption);
				OQS_KEM_kyber_512_decrypt(buffer32, ciphertext_512, secret_key_512);

				i += OQS_KEM_kyber_512_length_ciphertext;
			}
			else if (kyber_implementation == 2) {
				for (k = 0; k < OQS_KEM_kyber_768_length_ciphertext; k++) ciphertext_768[k] = 0x0;
				fread(ciphertext_768, 1, OQS_KEM_kyber_768_length_ciphertext, f_encryption);
				OQS_KEM_kyber_768_decrypt(buffer32, ciphertext_768, secret_key_768);
				i += OQS_KEM_kyber_768_length_ciphertext;
			}
			else if (kyber_implementation == 3) {
				for (k = 0; k < OQS_KEM_kyber_1024_length_ciphertext; k++) ciphertext_1024[k] = 0x0;
				fread(ciphertext_1024, 1, OQS_KEM_kyber_1024_length_ciphertext, f_encryption);
				OQS_KEM_kyber_1024_decrypt(buffer32, ciphertext_1024, secret_key_1024);
				i += OQS_KEM_kyber_1024_length_ciphertext;
			}
			fwrite(buffer32, 1, 32, f_decryption);
		}
		end_dec = clock();
		difference_enc = (long double)(end_enc - start_enc) / CLOCKS_PER_SEC * 1000;
		difference_dec = (long double)(end_dec - start_dec) / CLOCKS_PER_SEC * 1000;
		fclose(f_encryption);
		fclose(f_decryption);
		printf("\nTime to encrypt file %s (ms): %5.0Lf", input_file_path, difference_enc);
		printf("\nTime to decrypt file %s (ms): %5.0Lf", input_file_path, difference_dec);
	}
	else if (mode == 2) {
		printf("\nMulti-Threaded (CPU) Encryption/Decryption not available yet");
	}
	else if (mode == 3) {
		printf("\nMulti-Threaded (GPU) Encryption/Decryption not available yet");
	}
	return 0;
}