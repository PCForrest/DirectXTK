-- Implements the atgEnsureShadersForDirectXTK command

-- Inserts the following block immediately after the import "ExtensionTargets" group:

--  <Target Name="ATGEnsureShaders" BeforeTargets="PrepareForBuild">
--    <PropertyGroup>
--      <_ATGFXCPath>$(WindowsSDK_ExecutablePath_x64.Split(';')[0])</_ATGFXCPath>
--      <_ATGFXCPath>$(_ATGFXCPath.Replace("x64",""))</_ATGFXCPath>
--      <_ATGFXCPath Condition="'$(_ATGFXCPath)' != '' and !HasTrailingSlash('$(_ATGFXCPath)')">$(_ATGFXCPath)\</_ATGFXCPath>
--      <_ATGFXCVer>$([System.Text.RegularExpressions.Regex]::Match($(_ATGFXCPath), `10\.0\.\d+\.0`))</_ATGFXCVer>
--      <_ATGFXCVer Condition="'$(_ATGFXCVer)' != '' and !HasTrailingSlash('$(_ATGFXCVer)')">$(_ATGFXCVer)\</_ATGFXCVer>
--    </PropertyGroup>
--    <Exec Condition="!Exists('src/Shaders/Compiled/SpriteEffect_SpriteVertexShader.inc')" WorkingDirectory="$(ProjectDir)src/Shaders" Command="CompileShaders" EnvironmentVariables="WindowsSdkVerBinPath=$(_ATGFXCPath);WindowsSDKVersion=$(_ATGFXCVer);CompileShadersOutput=$(ProjectDir)Src/Shaders/Compiled" LogStandardErrorAsError="true" />
--    <PropertyGroup>
--      <_ATGFXCPath />
--      <_ATGFXCVer />
--    </PropertyGroup>
--  </Target>

require('vstudio')

local p = premake
local m = p.vstudio.vc2010

local function atgEnsureShadersForDirectXTK(prj)
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
			p.pop('</PropertyGroup>')
		p.pop('</Target>')
		printf("Generated 'ATGEnsureShaders' for DirectXTK project...")
	end
end

p.override(m.elements, "project", function(base, prj)
	local calls = base(prj)
	table.insertafter(calls, m.importExtensionTargets, atgEnsureShadersForDirectXTK)
	return calls
end)
