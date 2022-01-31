#include <time.h>

#include <iostream>
#include <fstream>
#include <random>

#define FILE_TO_REPLACE "README.md"
#define FILE_TO_WRITE "README.bak.md"
#define TAENGOO_MAX 18
#define WINTER_MAX 23

using namespace std;

int main()
{
    random_device rd;
    mt19937 gen(rd());
    string filePath = FILE_TO_REPLACE;
    string tmpPath = FILE_TO_WRITE;
    ifstream openFile(filePath.data());
    ofstream writeFile(tmpPath.data());
    uniform_int_distribution<int> taeng_random(1, TAENGOO_MAX);
    uniform_int_distribution<int> winter_random(1, WINTER_MAX);

    if (!openFile || !writeFile)
    {
        printf("Can't open files\n");
        return 1;
    }

    string line;
    while (getline(openFile, line))
    {
        if (line.find("alt=\"탱구\"", 0) != string::npos)
        {
            line.reserve(256);
            line = "<img src=\"https://marshallku.github.io/marshallku/assets/images/taengoo" + to_string(taeng_random(gen)) + ".gif\" alt=\"탱구\" height=\"150\" /><img src=\"https://marshallku.github.io/marshallku/assets/images/winter" + to_string(winter_random(gen)) + ".gif\" alt=\"윈터\" height=\"150\" />";
        }

        writeFile << line << "\n";
    }

    writeFile.close();
    openFile.close();

    remove(FILE_TO_REPLACE);
    rename(FILE_TO_WRITE, FILE_TO_REPLACE);

    return 0;
}
