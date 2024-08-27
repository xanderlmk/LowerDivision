#include <iostream>

using namespace std;

class BaseFile
{
    protected:
        string name;
        int size;
    public:
        void set_name(string n) 
        {
            name = n;
        }

};

class ImageFile : public BaseFile
{
    protected:
        int height, width;
    public:
        ImageFile()
        {
            height = 0;
            width = 0;
        }

        ImageFile(int h, int w)
        {
            height = h;
            width = w;
        }
};

class FramedImageFile : public ImageFile
{
    private:
        int frames;
    public:
        FramedImageFile()
        {
            height = 0;
            width = 0;
            frames = 0;
        }

        FramedImageFile(int h, int w, int f) : ImageFile (h, w)
    {
        height = h;
        width = w;
        frames = f;
    }

        friend ostream & operator<<(ostream & out, FramedImageFile rhs);
};

ostream & operator<<(ostream & out, FramedImageFile rhs)
{
    out << rhs.height << "x" << rhs.width << "x" << rhs.frames;
    return out;
}




int main()
{
    FramedImageFile * f1 = new FramedImageFile();

    int h, w, f;
    string n;

    cout << "Add height, width, and frames for Framed Imaged File" << endl;

    cout << "Height: ";
    cin >> h;

    cout << "Width: ";
    cin >> w;

    cout << "Frames: ";
    cin >> f;

    FramedImageFile(h, w, f);

    cout << "Also set a name for it." << endl;

    cin >> n;

    cout << "Height x Width x Frames" << endl;    
    cout << FramedImageFile(h,w, f) << endl;

    delete f1;

    return 0;
}
