#include <Hazel.h>

class SandboxApp : public Hazel::Application
{
public:
	SandboxApp()
	{
	}

	~SandboxApp()
	{
	}

};

int main()
{
	SandboxApp* app = new SandboxApp();
	app->Run();
	delete app;
}