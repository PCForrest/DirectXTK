-- Implement the atgDeleteShaders command
require('vstudio')

local p = premake
local m = p.vstudio.vc2010

local function atgDeleteShadersForDirectXTK(prj)
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

p.override(m.elements, "project", function(base, prj)
	local calls = base(prj)
	table.insertafter(calls, m.importExtensionTargets, atgDeleteShadersForDirectXTK)
	return calls
end)
