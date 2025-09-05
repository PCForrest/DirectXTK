require('vstudio')

local p = premake
local m = p.vstudio.vc2010

project "DirectXTK"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "Off"

	targetdir (bin_dir .. "/Libs/Vendor/%{prj.name}")
	objdir (int_dir .. "/Libs/Vendor/%{prj.name}")

	pchheader "pch.h"
	pchsource "%{prj.location}/Src/pch.cpp"

	files
	{
		"premake5.lua",
		".editorconfig",
		"Audio/*.h",
		"Audio/*.cpp",
		"Inc/*.h",
		"Inc/*.inl",
		"Src/*.h",
		"Src/*.cpp",
		"Src/Shaders/*.fx",
		"Src/Shaders/*.fxh",
		"Src/Shaders/*.hlsl",
		"Src/Shaders/*.hlsli",
		"Src/Shaders/*.cmd",
	}

	removefiles
	{
		"premake5.lua",
		".editorconfig",
		"Inc/XboxDDSTextureloader.h",
		"Src/XboxDDSTextureloader.cpp",
	}

	includedirs
	{
		"Inc",
		"Src",
		"Src/Shaders",
		"Src/Shaders/Compiled",
	}

	dependson
	{
		-- nil
	}

	links
	{
		-- nil
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

	--[[ FUNCTIONS ]]

	local function ensure_shaders_for_directx_tk(prj)
		if (prj.name == "DirectXTK") then
			p.push('<Target Name="ATGEnsureShaders" BeforeTargets="PrepareForBuild">')
				p.push('<PropertyGroup>')
					p.w('<_ATGFXCPath>$(WindowsSDK_ExecutablePath_x64.Split(\';\')[0])</_ATGFXCPath>')
					p.w('<_ATGFXCPath>$(_ATGFXCPath.Replace("x64",""))</_ATGFXCPath>')
					p.w('<_ATGFXCPath Condition="\'$(_ATGFXCPath)\' != \'\' and !HasTrailingSlash(\'$(_ATGFXCPath)\')">$(_ATGFXCPath)\\</_ATGFXCPath>')
					p.w('<_ATGFXCVer>$([System.Text.RegularExpressions.Regex]::Match($(_ATGFXCPath), `10\\.0\\.\\d+\\.0`))</_ATGFXCVer>')
					p.w('<_ATGFXCVer Condition="\'$(_ATGFXCVer)\' != \'\' and !HasTrailingSlash(\'$(_ATGFXCVer)\')">$(_ATGFXCVer)\\</_ATGFXCVer>')
				p.pop('</PropertyGroup>')
				p.w('<Exec Condition="!Exists(\'src/Shaders/Compiled/SpriteEffect_SpriteVertexShader.inc\')" WorkingDirectory="$(ProjectDir)src/Shaders" Command="CompileShaders" EnvironmentVariables="WindowsSdkVerBinPath=$(_ATGFXCPath)" />')
				p.push('<PropertyGroup>')
					p.w('<_ATGFXCPath />')
					p.w('<_ATGFXCVer />')
				p.pop('</PropertyGroup>')
			p.pop('</Target>')
			printf("Generated 'ATGEnsureShaders' for DirectXTK project...")
		end
	end

	local function delete_shaders_for_directx_tk(prj)
		if (prj.name == "DirectXTK") then
			p.push('<Target Name="ATGDeleteShaders" AfterTargets="Clean">')
				p.push('<ItemGroup>')
					p.w('<_ATGShaderHeaders Include="$(ProjectDir)src/Shaders/Compiled/*.inc" Exclude="$(ProjectDir)src/Shaders/Compiled/*Xbox*.inc" />')
					p.w('<_ATGShaderSymbols Include="$(ProjectDir)src/Shaders/Compiled/*.pdb" Exclude="$(ProjectDir)src/Shaders/Compiled/*Xbox*.pdb" />')
				p.pop('</ItemGroup>')
				p.w('<Delete Files="@(_ATGShaderHeaders)" />')
				p.w('<Delete Files="@(_ATGShaderSymbols)" />')
			p.pop('</Target>')
			printf("Generated 'ATGDeleteShaders' for DirectXTK project...")
		end
	end

	--[[ OVERRIDE ]]

	p.override(m.elements, "project", function(base, prj)
		local calls = base(prj)
		table.insertafter(calls, m.importExtensionTargets, delete_shaders_for_directx_tk)
		table.insertafter(calls, m.importExtensionTargets, ensure_shaders_for_directx_tk)
		return calls
	end)
