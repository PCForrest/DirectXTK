require('vstudio')

local p = premake
local m = p.vstudio.vc2010

project "DirectXTK"
	kind "StaticLib"
	language "C++"

	targetdir (bin_dir .. "/Libs/Vendor/%{prj.name}")
	objdir (int_dir .. "/Libs/Vendor/%{prj.name}")

	pchheader "pch.h"
	pchsource "Src/pch.cpp"

	files{
		"premake5.lua",
		".editorconfig",
		"Audio/*.h",
		"Audio/*.cpp",
		"Inc/*.h",
		"Inc/*.inl",
		"Src/*.h",
		"Src/*.cpp",
		"Src/*.inc",
		"Src/Shaders/*.fx",
		"Src/Shaders/*.fxh",
		"Src/Shaders/*.hlsl",
		"Src/Shaders/*.hlsli",
		"Src/Shaders/*.cmd",
		"README.md",
	}

	removefiles	{
		"premake5.lua",
		".editorconfig",
		"Inc/XboxDDSTextureloader.h",
		"Src/XboxDDSTextureloader.cpp",
	}

	vpaths	{
		["Audio"] =
		{
			"Inc/Audio.h",
			"Audio/AudioEngine.cpp",
			"Audio/DynamicSoundEffectInstance.cpp",
			"Audio/SoundCommon.h",
			"Audio/SoundCommon.cpp",
			"Audio/SoundEffect.cpp",
			"Audio/SoundEffectInstance.cpp",
			"Audio/SoundStreamInstance.cpp",
			"Audio/WaveBank.cpp",
			"Audio/WaveBankReader.cpp",
			"Audio/WaveBankReader.h",
			"Audio/WAVFileReader.cpp",
			"Audio/WAVFileReader.h",
		},
		["Inc/Shared"] =
		{
			"Inc/GamePad.h",
			"Inc/Keyboard.h",
			"Inc/Mouse.h",
			"Inc/SimpleMath.h",
			"Inc/SimpleMath.inl",
		},
		["Inc"] =
		{
			"Inc/BufferHelpers.h",
			"Inc/CommonStates.h",
			"Inc/DDSTextureLoader.h",
			"Inc/DirectXHelpers.h",
			"Inc/Effects.h",
			"Inc/GeometricPrimitive.h",
			"Inc/GraphicsMemory.h",
			"Inc/Model.h",
			"Inc/PostProcess.h",
			"Inc/PrimtiveBatch.h",
			"Inc/SceenGrab.h",
			"Inc/SpriteBatch.h",
			"Inc/SpriteFont.h",
			"Inc/VertexTypes.h",
			"Inc/WICTextureLoader.h",
		},
		["Src/Shaders/Shared"] =
		{
			"Src/Shaders/Common.fxh",
			"Src/Shaders/Lighting.fxh",
			"Src/Shaders/PBRCommon.fxh",
			"Src/Shaders/PixelPacking_Velocity.hlsli",
			"Src/Shaders/Skinning.fxh",
			"Src/Shaders/Structures.fxh",
			"Src/Shaders/Utilities.fxh",
		},
		["Src/Shaders"] =
		{
			"Src/Shaders/AlphaTestEffect.fx",
			"Src/Shaders/BasicEffect.fx",
			"Src/Shaders/CompileShaderscmd",
			"Src/Shaders/DebugEffect.fx",
			"Src/Shaders/DGSLEffect.fx",
			"Src/Shaders/DGSLLambert.hlsl",
			"Src/Shaders/DGSLPhong.hlsl",
			"Src/Shaders/DGSLUnlit.fx",
			"Src/Shaders/DualTextureEffect.fx",
			"Src/Shaders/EnvironmentMapEffect.fx",
			"Src/Shaders/NormalMapEffect.fx",
			"Src/Shaders/PBREffect.fx",
			"Src/Shaders/PostProcess.fx",
			"Src/Shaders/SkinnedEffect.fx",
			"Src/Shaders/SpriteEffect.fx",
			"Src/Shaders/ToneMap.fx",
		},
		["Src/Shared"] =
		{
			"Src/AlignedNew.h",
			"Src/Bezier.h",
			"Src/BinaryReader.cpp",
			"Src/BinaryReader.h",
			"Src/CMO.h",
			"Src/DDS.h",
			"Src/DemandCreate.h",
			"Src/GamePad.cpp",
			"Src/Geometry.cpp",
			"Src/Geometry.h",
			"Src/Keyboard.cpp",
			"Src/LoaderHelpers.h",
			"Src/Mouse.cpp",
			"Src/SDKMesh.h",
			"Src/SharedResourcePool.h",
			"Src/SimpleMath.cpp",
			"Src/TeapotData.inc",
			"Src/vbo.h",
		},
		["Src"] =
		{
			"Src/AlphaTestEffect.cpp",
			"Src/BasicEffect.cpp",
			"Src/BasicPostProcess.cpp",
			"Src/BufferHelpers.cpp",
			"Src/CommonStates.cpp",
			"Src/DDSTextureLoader.cpp",
			"Src/DebugEffect.cpp",
			"Src/DGSLEffect.cpp",
			"Src/DGSLEffectFactory.cpp",
			"Src/DirectXHelpers.cpp",
			"Src/DualPostProcess.cpp",
			"Src/DualTextureEffect.cpp",
			"Src/EffectCommon.cpp",
			"Src/EffectCommon.h",
			"Src/EffectFactory.cpp",
			"Src/EnvironmentMapEffect.cpp",
			"Src/GeometricPrimitive.cpp",
			"Src/GraphicsMemory.cpp",
			"Src/Model.cpp",
			"Src/ModelLoadCMO.cpp",
			"Src/ModelLoadSDKMESH.cpp",
			"Src/ModelLoadVBO.cpp",
			"Src/NormalMapEffect.cpp",
			"Src/PBREffect.cpp",
			"Src/PBREffectFactory.cpp",
			"Src/pch.cpp",
			"Src/pch.h",
			"Src/PlatformHelpers.h",
			"Src/PrimitiveBatch.cpp",
			"Src/ScreenGrab.cpp",
			"Src/SkinnedEffect.cpp",
			"Src/SpriteBatch.cpp",
			"Src/SpriteFont.cpp",
			"Src/ToneMapPostProcess.cpp",
			"Src/VertexTypes.cpp",
			"Src/WICTextureLoader.cpp",
		},
	}

	includedirs	{
		"Inc",
		"Src",
		"Src/Shaders",
		"Src/Shaders/Compiled",
	}

	dependson	{
		-- nil
	}

	links	{
		-- nil
	}

	defines	{
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
		cppdialect "C++17"
		staticruntime "off"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"
		staticruntime "off"

	filter "configurations:Debug"
		defines { "_DEBUG" }
		runtime "Debug"
		symbols "on"

	filter "configurations:Profile"
		defines { "NDEBUG" }
		runtime "Release"
		optimize "on"

	filter "configurations:Release"
		defines { "NDEBUG" }
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
