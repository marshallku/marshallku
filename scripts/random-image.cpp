#include <time.h>

#include <iostream>
#include <fstream>
#include <random>
#include <random>

#define FILE_TO_REPLACE "README.md"
#define FILE_TO_WRITE "README.bak.md"
#define TAENGOO_MAX 9
#define WINTER_MAX 9

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
        cout << "Can't open files" << endl;
        return 1;
    }

    string line;
    while (getline(openFile, line))
    {
        if (line.rfind("![탱구]", 0) == 0)
        {
            line = "![탱구](https://marshallku.github.io/marshallku/assets/images/taengoo";
            line += to_string(taeng_random(gen));
            line += ".gif)![윈터](https://marshallku.github.io/marshallku/assets/images/winter";
            line += to_string(winter_random(gen));
            line += ".gif)";
            cout << line << endl;
        }

        line += "\n";
        writeFile << line;
    }

    writeFile.close();
    openFile.close();

    remove(FILE_TO_REPLACE);
    rename(FILE_TO_WRITE, FILE_TO_REPLACE);

    return 0;
}
