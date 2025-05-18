workspace "Hazel"
   architecture "x64"
   configurations
   {
	   "Debug",
	   "Release",
	   "Dist"
   }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("Out/Bin/" .. outputdir .. "/%{prj.name}")
	objdir ("Out/Obj/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include",
	}

	filter "system:windows"
		cppdialect "C++23"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HAZEL_PLATFORM_WINDOWS",
			"HAZEL_BUILD_DLL",
		}

		postbuildcommands
		{
			("{MKDIR} ../Out/Bin/" .. outputdir .. "/Sandbox"),
			("{COPYFILE} %{cfg.buildtarget.relpath} ../Out/Bin/" .. outputdir .. "/Sandbox"),
		}

		buildoptions "/utf-8"

	filter "configurations:Debug"
		defines "HAZEL_DEBUG"
		symbols "On"


	filter "configurations:Release"
		defines "HAZEL_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HAZEL_DIST"
		optimize "On"


project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("Out/Bin/" .. outputdir .. "/%{prj.name}")
	objdir ("Out/Obj/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src",
	}

	links
	{
		"Hazel",
	}

	buildoptions "/utf-8"

	filter "system:windows"
		cppdialect "C++23"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HAZEL_PLATFORM_WINDOWS",
		}

	filter "configurations:Debug"
		defines "HAZEL_DEBUG"
		symbols "On"


	filter "configurations:Release"
		defines "HAZEL_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HAZEL_DIST"
		optimize "On"