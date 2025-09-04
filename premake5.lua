project "DirectXTK"
	kind "StaticLib"

include "premake5.vstudio.vc2010.project.override.lua"

	language "C++"
	cppdialect "C++17"
	staticruntime "Off"
	location "%{wks.location}/Libs/Vendor/%{prj.name}"

	targetdir (bin_dir .. "/Libs/Vendor/%{prj.name}")
	objdir (int_dir .. "/Libs/Vendor/%{prj.name}")

	pchheader "pch.h"
	pchsource "%{prj.location}/Src/pch.cpp"

	files
	{
		"%{prj.location}/premake5.lua",
		"%{prj.location}/.editorconfig",
		"%{prj.location}/Audio/*.h",
		"%{prj.location}/Audio/*.cpp",
		"%{prj.location}/Inc/*.h",
		"%{prj.location}/Inc/*.inl",
		"%{prj.location}/Src/*.h",
		"%{prj.location}/Src/*.cpp",
		"%{prj.location}/Src/Shaders/*.fx",
		"%{prj.location}/Src/Shaders/*.fxh",
		"%{prj.location}/Src/Shaders/*.hlsl",
		"%{prj.location}/Src/Shaders/*.hlsli",
		"%{prj.location}/Src/Shaders/*.cmd",
	}

	removefiles
	{
		"%{prj.location}/premake5.lua",
		"%{prj.location}/.editorconfig",
		"%{prj.location}/Inc/XboxDDSTextureloader.h",
		"%{prj.location}/Src/XboxDDSTextureloader.cpp",
	}

	includedirs
	{
		"%{prj.location}/Inc",
		"%{prj.location}/Src",
		"%{prj.location}/Src/Shaders",
		"%{prj.location}/Src/Shaders/Compiled",
	}

	dependson
	{
		-- Nil
	}

	links
	{
		-- Nil
	}

	defines
	{
		"_WIN32_WINNT=0x0A00",
		"WIN32",
		"_LIB",
		"_CRT_STDIO_ARBITRARY_WIDE_SPECIFIERS",
	}

	filter "files:**.fx"
		buildaction "None"

	filter "files:**.fxh"
		buildaction "None"

	filter "files:**.hlsl"
		buildaction "None"

	filter "files:**.hlsli"
		buildaction "None"

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		defines	{ "_DEBUG",	}
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines	{ "NDEBUG", }
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines	{ "NDEBUG", }
		runtime "Release"
		optimize "on"

	filter {}
