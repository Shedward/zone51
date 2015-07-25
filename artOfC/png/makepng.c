#include <stdio.h>
#include <math.h>
#include <malloc.h>
#include <png.h>

float *createMandelbrotImage(int width, int height, float xS, float yS, float rad, int maxIteration);

inline void setRGB(png_byte *ptr, float val);

int writeImage(char* filename, int width, int height, float *buffer, char* title);


int main(int argc, char **argv) 
{	
	if (argc != 2) {
		fprintf(stderr, "Please specify output file\n");
		return 1;
	}

	int width = 500;
	int height = 500;
	
	printf("Creating Image\n");

	float* buffer = createMandelbrotImage(width, height, -0.802f, -0.177, 0.011, 110);
	if (buffer == NULL) {
		return 1;
	}

	printf("Saving PNG\n");

	int result = writeImage(argv[1], width, height, buffer, "TestImage");

	free(buffer);

	return result;
}


inline void setRGB(png_byte *ptr, float val) 
{
	int v = (int)(val * 767);
	if (v < 0) v = 0;
	if (v > 767) v = 767;
	int offset = v % 256;

	if (v < 256) {
		ptr[0] = 0; ptr[1] = 0; ptr[2] = offset;
	} else if (v < 512) {
		ptr[0] = 0; ptr[1] = offset; ptr[2] = 255 - offset;
	} else {
		ptr[0] = offset; ptr[1] = 255 - offset; ptr[2] = 0;
	}
}

int writeImage(char* filename, int width, int height, float *buffer, char* title)
{
	int code = 0;

	FILE *fp = NULL;
	png_structp png_p = NULL;
	png_infop info_p = NULL;
	png_bytep row = NULL;

	fp = fopen(filename, "wb");

	if (fp == NULL) {
		fprintf(stderr, "Could not open file %s for writing\n", filename);
		code = 1;
		goto finilize;
	}

	png_p = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

	if (png_p == NULL) {
		fprintf(stderr, "Could not allocate write struct\n");
		code = 1;
		goto finilize;
	}

	info_p = png_create_info_struct(png_p);
	if (info_p == NULL) {
		fprintf(stderr, "Could not allocate info struct\n");
		code = 1;
		goto finilize;
	}

	if (setjmp(png_jmpbuf(png_p))) {
		fprintf(stderr, "Error during png creation");
		code = 1;
		goto finilize;
	}

	png_init_io(png_p, fp);

	png_set_IHDR(png_p, info_p, width, height,
			8, PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
			PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

	if (title != NULL) {
		png_text title_text = title_text;
		title_text.compression = PNG_TEXT_COMPRESSION_NONE;
		title_text.key = "Title";
		title_text.text = title;
		png_set_text(png_p, info_p, &title_text, 1);
	}

	png_write_info(png_p, info_p);

	row = (png_bytep) malloc(3 * width * sizeof(png_byte));

	int x, y;
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			setRGB(&(row[x * 3]), buffer[y * width + x]);
		}
		png_write_row(png_p, row);
	}

	png_write_end(png_p, NULL);

finilize:
	if (fp != NULL) fclose(fp);
	if (info_p != NULL) png_free_data(png_p, info_p, PNG_FREE_ALL, -1);
	if (png_p!= NULL) png_destroy_write_struct(&png_p, (png_infopp)NULL);
	if (row != NULL) free(row);

	return code;
}

float *createMandelbrotImage(int width, int height, float xS, float yS, float rad, int maxIteration)
{
	float *buffer = (float *) malloc(width * height * sizeof(float));
	if (buffer == NULL) {
		fprintf(stderr, "Could not create image buffer\n");
		return NULL;
	}

	int xPos, yPos;
	float minMu = maxIteration;
	float maxMu = 0;

	for (yPos = 0; yPos < height; yPos++) {
		float yP = (yS - rad) + (2.0f * rad / height) * yPos;

		for (xPos = 0; xPos < width; xPos++) {
			float xP = (xS - rad) + (2.0f * rad / width)* xPos;

			int iteration = 0;
			float x = 0;
			float y = 0;

			while (x*x + y*y <= 4 && iteration < maxIteration) {
				y = 2*x*y + yP;
				x = x*x - y*y + xP;
				iteration++;
			}

			if (iteration < maxIteration) {
				float modZ = sqrt(x*x + y*y);
				float mu = iteration - log(log(modZ)) / log(2);
				if (mu > maxMu) maxMu = mu;
				if (mu < minMu) minMu = mu;

				buffer[yPos * width + xPos] = mu;
			} else {
				buffer[yPos * width + xPos] = 0;

			}
		}
	}

	int count = width * height;
	while (count) {
		count--;
		buffer[count] = (buffer[count] - minMu) / (maxMu - minMu);
	}

	return buffer;
}
