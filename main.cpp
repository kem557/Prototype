#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>
#include <iostream>
#include "crypt.c";

#pragma warning(disable : 4996)
using namespace cv;
using namespace std;

// constant declarations
const string CASCADE_CLASSIFIER = "Resources/haarcascade_frontalface_default.xml";
// function declarations
string getInputFile();
int getKyber();
int getFaces(string, int);
double* crypt(int kyber_implementation, char* input_file_path, char* encryption_file_path, char* decryption_file_path);

// Main
int main() 
{
	// Step 1: get input file from user
	string path = getInputFile();
	int kyberImplementation = getKyber();
	Mat img = imread(path);

	// Step 2: Facial Recognition: generate face image files, duplicate input image with face rectangles drawn
	getFaces(path, kyberImplementation);

	// TODO Step 3: encrypt and decrypt each face file

	return 0;
}


// Step 1: get input file from user
// TODO:  add input validation
string getInputFile()
{
	string path;
	cout << "Enter input file, including extension (from Input folder):\n\tEnter:\t";
	cin >> path;
	path = "Input/" + path;
	return path;
}

int getKyber()
{
	int kyberImplementation;
	cout << "\nEnter Kyber Implementation: 1. Kyber512\t2. Kyber768\t3. Kyber1024\n\tEnter:\t";
	cin >> kyberImplementation;
	
	return kyberImplementation;
}


// Step 2: detect faces, output face files and face outlines file
int getFaces(string inputPath, int kyberImplementation)
{
	// Load facial recognition XML
	CascadeClassifier faceCascade;
	faceCascade.load(CASCADE_CLASSIFIER);

	// test for loaded xml file
	if (faceCascade.empty()) 
	{
		cout << "facial recognition XML file not loaded" << endl;
	}

	// initialize imag matrix from input path
	Mat img = imread(inputPath);

	vector<Rect> faces;
	faceCascade.detectMultiScale(img, faces, 1.1, 8);	// detect faces

	// for each detected face: save as separate image, draw rectangle 
	for (int i = 0; i < faces.size(); i++)
	{
		// Get dimensions for face
		int xLower = faces[i].tl().x;
		int xUpper = faces[i].br().x;
		int yLower = faces[i].br().y;
		int yUpper = faces[i].tl().y;

		Mat croppedImage = img(Range(yUpper, yLower), Range(xLower, xUpper));

		// build filepath, output each croppedImage to a separate file
		string outputPath = ("Output/face" + to_string(i) + ".bmp");
		string encryptedPath = ("Output/Encryption/face" + to_string(i) + ".bmp");
		string decryptedPath = ("Output/Decryption/face" + to_string(i) + ".bmp");
		imwrite(outputPath, croppedImage);

		// draw rectangle around face in original image
		rectangle(img, faces[i].tl(), faces[i].br(), Scalar(0, 255, 0), 2);	

		// pass face file to crypt function
		// input arguments for crypt: char* kyber_implementation, char* input_file_path, char* encryption_file_path, char* decryption_file_path
		char output_path[1024];
		char encrypted_path[1024];
		char decrypted_path[1024];
		strncpy(output_path, outputPath.c_str(), sizeof(output_path));
		strncpy(encrypted_path, encryptedPath.c_str(), sizeof(encrypted_path));
		strncpy(decrypted_path, decryptedPath.c_str(), sizeof(decrypted_path));


		crypt(kyberImplementation,output_path,encrypted_path,decrypted_path);
		Mat encrypted = imread(encrypted_path);
		Mat decrypted = imread(decrypted_path);
		string encrypted_window = "Encrypted Image " + to_string(i);
		string decrypted_window = "Decrypted Image " + to_string(i);
		namedWindow(encrypted_window, WINDOW_NORMAL);
		namedWindow(decrypted_window, WINDOW_NORMAL);
		imshow(encrypted_window, encrypted);
		imshow(decrypted_window, decrypted);
	}

	// output full image with overlayed rectangles
	imwrite("Output/detectedfaces.jpg", img);

	// show detected faces in a display window
	imshow("Display Window", img);
	waitKey(0);

	return 0;
}