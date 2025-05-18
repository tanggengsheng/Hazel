#pragma once

#ifdef HAZEL_PLATFORM_WINDOWS
extern Hazel::Application* Hazel::CreateApplication();
int main(int argc, char* argv[])
{
	Hazel::Log::Init();
	HAZEL_CORE_INFO("Hazel Engine Initialized!");
	HAZEL_CLIENT_INFO("Hello!");

	auto app = Hazel::CreateApplication();
	app->Run();
	delete app;
}
#else
	#error "Hazel only supports Windows!"
#endif