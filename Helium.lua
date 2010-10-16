function DoDefaultSolutionSetup()

	location "Premake"
	
    platforms
    {
		"x32",
		"x64",
	}

	configurations
	{
		"Debug",
		"DebugUnicode",
		"Release",
		"ReleaseUnicode",
	}

--[[
	Iterate through our platforms and configurations and set them up with appropriate
	target directories (that have both the configuration and platform built into them)
--]]
	for i, platform in ipairs( platforms() ) do
		for j, config in ipairs( configurations() ) do
			configuration( { config, platform } )
				targetdir( "Bin/" .. platform .. "/" .. config )
		end
	end

--[[
	Keep in mind that solution-wide settings should be defined
	before ever mentioning configuration-specific settings because
	the indentation in this file is for humans (not premake), and
	premake might infer conditionals when walking the graph of 
	solutions/configurations/projects -Geoff
--]]

	configuration "windows"
		defines
		{
			"_WIN32",
			"WIN32",
			"_CRT_SECURE_NO_DEPRECATE",
		}
		flags
		{
			"NoMinimalRebuild",
		}

	configuration "Debug*"
		defines
		{
			"_DEBUG",
		}
		flags
		{
			"Symbols",
		}

	configuration "Release*"
		defines
		{
			"NDEBUG",
		}
		flags
		{
			"Optimize",
		}

	configuration "*Unicode"
		defines
		{
			"UNICODE=1",
			"LITESQL_UNICODE=1",
			"XML_UNICODE_WCHAR_T=1",
		}
		flags
		{
			"Unicode",
		}

end

function Sleep( seconds )
	if os.get() == "windows" then
		os.execute("ping 127.0.0.1 -n " .. seconds + 1 .. " -w 1000 >:nul 2>&1")
	else
		os.execute("sleep " .. seconds)
	end
end

function Publish( files )
	for i,v in pairs(files) do
		-- mkpath the target folder
		os.mkdir( v.built )
		
		local path = v.dir .. "/" .. v.file			
		local exists = os.isfile( path )
		local destination = v.built .. "/" .. v.file

		-- cull existing files
		if os.isfile( destination ) then
			os.execute( "del /q \"" .. string.gsub( destination, "/", "\\" ) .. "\"" )
		end

		-- do the file copy
		local result = os.execute( "mklink /h \"" .. destination .. "\" \"" .. path .. "\"" )

		-- the files were copied, complete this entry
		if result == 0 then
			files[ i ] = nil
		else
			os.exit( 1 )
		end						
	end
end

function BuildWxWidgets()

	local cwd = os.getcwd()

	local files = {}
	
	if os.get() == "windows" then
		local make = "nmake.exe -f makefile.vc SHARED=1 MONOLITHIC=1 DEBUG_INFO=1"

		if not os.getenv("VCINSTALLDIR") then
			print("VCINSTALLDIR is not detected in your environment")
			os.exit(1)
		end
				
		os.chdir( "Dependencies/wxWidgets/build/msw" );

		local result
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=debug UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=release UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=debug UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=release UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=debug UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=release UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=debug UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=release UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end

		os.chdir( cwd )
		files[1]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291d_vc_custom.dll",		built="Bin/x32/Debug" }
		files[2]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291d_vc_custom.pdb",		built="Bin/x32/Debug" }
		files[3]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291_vc_custom.dll",		built="Bin/x32/Release" }
		files[4]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291_vc_custom.pdb",		built="Bin/x32/Release" }
		files[5]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291ud_vc_custom.dll",	built="Bin/x32/DebugUnicode" }
		files[6]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291ud_vc_custom.pdb",	built="Bin/x32/DebugUnicode" }
		files[7]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291u_vc_custom.dll",		built="Bin/x32/ReleaseUnicode" }
		files[8]  = { dir="Dependencies/wxWidgets/lib/vc_dll", 			file="wxmsw291u_vc_custom.pdb",		built="Bin/x32/ReleaseUnicode" }
		files[9]  = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291d_vc_custom.dll",		built="Bin/x64/Debug" }
		files[10] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291d_vc_custom.pdb",		built="Bin/x64/Debug" }
		files[11] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291_vc_custom.dll",		built="Bin/x64/Release" }
		files[12] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291_vc_custom.pdb",		built="Bin/x64/Release" }
		files[13] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291ud_vc_custom.dll",	built="Bin/x64/DebugUnicode" }
		files[14] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291ud_vc_custom.pdb",	built="Bin/x64/DebugUnicode" }
		files[15] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291u_vc_custom.dll",		built="Bin/x64/ReleaseUnicode" }
		files[16] = { dir="Dependencies/wxWidgets/lib/vc_amd64_dll", 	file="wxmsw291u_vc_custom.pdb",		built="Bin/x64/ReleaseUnicode" }
		Publish( files )
	else
		print("Implement support for " .. os.get() .. " to BuildWxWidgets()")
		os.exit(1)
	end

end

function CleanWxWidgets()

	local cwd = os.getcwd()

	local files = {}
	
	if os.get() == "windows" then
		local make = "nmake.exe -f makefile.vc clean SHARED=1 MONOLITHIC=1 DEBUG_INFO=1"

		if not os.getenv("VCINSTALLDIR") then
			print("VCINSTALLDIR is not detected in your environment")
			os.exit(1)
		end
				
		os.chdir( "Dependencies/wxWidgets/build/msw" );

		local result
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=debug UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=release UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=debug UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=release UNICODE=0\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=debug UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat x86 && " .. make .. " BUILD=release UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=debug UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
		result = os.execute( "cmd.exe /c \"call \"%VCINSTALLDIR%\"\\vcvarsall.bat amd64 && " .. make .. " TARGET_CPU=AMD64 BUILD=release UNICODE=1\"" )
		if result ~= 0 then os.exit( 1 ) end
	else
		print("Implement support for " .. os.get() .. " to CleanWxWidgets()")
		os.exit(1)
	end

end

solution "Dependencies"

	if _ACTION ~= "clean" then
		BuildWxWidgets()
	else
		CleanWxWidgets()
	end

	DoDefaultSolutionSetup()
	
	project "Expat"
		kind "StaticLib"
		language "C++"
		defines
		{
			"COMPILED_FROM_DSP",
		}
		files
		{
			"Dependencies/Expat/*.h",
			"Dependencies/Expat/*.c",
		}

	project "LiteSQL"
		kind "StaticLib"
		language "C++"
		includedirs
		{
			"Dependencies/Expat",
			"Dependencies/LiteSQL/include",
			"Dependencies/LiteSQL/src/library",
		}
		files
		{
			"Dependencies/LiteSQL/include/**.cpp",
			"Dependencies/LiteSQL/include/**.h",
			"Dependencies/LiteSQL/include/**.hpp",
			"Dependencies/LiteSQL/src/library/**.c",
			"Dependencies/LiteSQL/src/library/**.cpp",
			"Dependencies/LiteSQL/src/library/**.h",
			"Dependencies/LiteSQL/src/library/**.hpp",
			"Dependencies/LiteSQL/src/generator/generator.cpp",
			"Dependencies/LiteSQL/src/generator/generator.hpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-cpp.cpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-cpp.hpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-graphviz.cpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-graphviz.hpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-ruby-activerecord.cpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-ruby-activerecord.hpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-xml.cpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen-xml.hpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen.cpp",
			"Dependencies/LiteSQL/src/generator/litesql-gen.hpp",
			"Dependencies/LiteSQL/src/generator/logger.cpp",
			"Dependencies/LiteSQL/src/generator/logger.hpp",
			"Dependencies/LiteSQL/src/generator/md5.cpp",
			"Dependencies/LiteSQL/src/generator/md5.hpp",
			"Dependencies/LiteSQL/src/generator/objectmodel.cpp",
			"Dependencies/LiteSQL/src/generator/objectmodel.hpp",
			"Dependencies/LiteSQL/src/generator/xmlobjects.cpp",
			"Dependencies/LiteSQL/src/generator/xmlobjects.hpp",
			"Dependencies/LiteSQL/src/generator/xmlparser.cpp",
			"Dependencies/LiteSQL/src/generator/xmlparser.hpp",
		}

	project "Lua"
		kind "StaticLib"
		language "C++"
		files
		{
			"Dependencies/lua/src/*.h",
			"Dependencies/lua/src/*.c",
		}
		excludes
		{
			"Dependencies/lua/src/luac.c",
		}
		
	project "nvtt"
		kind "StaticLib"
		language "C++"
		defines
		{
			"__SSE2__",
			"__SSE__",
			"__MMX__",
		}
		includedirs
		{
			"Dependencies/nvtt/src",
		}
		files
		{
			"Dependencies/nvtt/src/nvmath/*.h",
			"Dependencies/nvtt/src/nvmath/*.cpp",
			"Dependencies/nvtt/src/nvcore/*.h",
			"Dependencies/nvtt/src/nvcore/*.cpp",
			"Dependencies/nvtt/src/nvimage/*.h",
			"Dependencies/nvtt/src/nvimage/*.cpp",
		}
		excludes
		{
			"Dependencies/nvtt/src/nvcore/Tokenizer.h",
			"Dependencies/nvtt/src/nvcore/Tokenizer.cpp",
			"Dependencies/nvtt/src/nvimage/ConeMap.h",
			"Dependencies/nvtt/src/nvimage/ConeMap.cpp",
		}
		
		configuration "windows"
			includedirs
			{
				"Dependencies/nvtt/project/vc8",
			}

	project "squish"
		kind "StaticLib"
		language "C++"
		includedirs
		{
			"Dependencies/squish",
		}
		files
		{
			"Dependencies/squish/*.h",
			"Dependencies/squish/*.inl",
			"Dependencies/squish/*.cpp",
		}

	project "tiff"
		kind "StaticLib"
		language "C++"
		includedirs
		{
			"Dependencies/tiff",
			"Dependencies/tiff/libtiff",
		}
		files
		{
			"Dependencies/tiff/libtiff/*.h",
			"Dependencies/tiff/libtiff/*.c",
		}
		
		configuration "windows"
			excludes
			{
				"Dependencies/tiff/libtiff/tif_acorn.c",
				"Dependencies/tiff/libtiff/tif_atari.c",
				"Dependencies/tiff/libtiff/tif_apple.c",
				"Dependencies/tiff/libtiff/tif_msdos.c",
				"Dependencies/tiff/libtiff/tif_unix.c",
				"Dependencies/tiff/libtiff/tif_win3.c",
			}
		configuration "macosx"
			excludes
			{
				"Dependencies/tiff/libtiff/tif_acorn.c",
				"Dependencies/tiff/libtiff/tif_atari.c",
				"Dependencies/tiff/libtiff/tif_msdos.c",
				"Dependencies/tiff/libtiff/tif_unix.c",
				"Dependencies/tiff/libtiff/tif_win3.c",
				"Dependencies/tiff/libtiff/tif_win32.c",
			}
		configuration "linux"
			excludes
			{
				"Dependencies/tiff/libtiff/tif_acorn.c",
				"Dependencies/tiff/libtiff/tif_atari.c",
				"Dependencies/tiff/libtiff/tif_apple.c",
				"Dependencies/tiff/libtiff/tif_msdos.c",
				"Dependencies/tiff/libtiff/tif_win3.c",
				"Dependencies/tiff/libtiff/tif_win32.c",
			}

	project "zlib"
		kind "StaticLib"
		language "C++"
		files
		{
			"Dependencies/zlib/*.h",
			"Dependencies/zlib/*.c",
		}
		excludes
		{
			"Dependencies/zlib/gz*.h",
			"Dependencies/zlib/gz*.c",
			"Dependencies/zlib/minigzip.c",
		}

solution "Helium"

	defines
	{
		"PLATFORM_DLL=1",
		"FOUNDATION_DLL=1",
		"PIPELINE_DLL=1",
		"CORE_DLL=1",
		"XML_STATIC=1",
		"WXUSINGDLL=1",
		"wxUSE_UNICODE=0",
		"wxNO_EXPAT_LIB=1",
		"wxNO_JPEG_LIB=1",
		"wxNO_PNG_LIB=1",
		"wxNO_TIFF_LIB=1",
		"wxNO_ZLIB_LIB=1",
	}

	includedirs
	{
		".",
	}
	
	buildoptions
	{
		-- Class 'foo<>' needs to have dll-interface to be used by clients of class 'bar'
		--  This is a non-issue so long as debug/release and CRT is not mixed b/t modules
		"/wd4251",
	}
	
	DoDefaultSolutionSetup()

--[[
	We build monolithic wx, so ignore all the legacy non-monolithic
	#pragma comment directives (on windows only)
--]]
	configuration "windows"
		linkoptions
		{
			"/NODEFAULTLIB:wxbase29ud",
			"/NODEFAULTLIB:wxbase29d",
			"/NODEFAULTLIB:wxbase29u",
			"/NODEFAULTLIB:wxbase29",
			"/NODEFAULTLIB:wxbase29ud_net",
			"/NODEFAULTLIB:wxbase29d_net",
			"/NODEFAULTLIB:wxbase29u_net",
			"/NODEFAULTLIB:wxbase29_net",
			"/NODEFAULTLIB:wxbase29ud_xml",
			"/NODEFAULTLIB:wxbase29d_xml",
			"/NODEFAULTLIB:wxbase29u_xml",
			"/NODEFAULTLIB:wxbase29_xml",
			"/NODEFAULTLIB:wxmsw29ud_core",
			"/NODEFAULTLIB:wxmsw29d_core",
			"/NODEFAULTLIB:wxmsw29u_core",
			"/NODEFAULTLIB:wxmsw29_core",
			"/NODEFAULTLIB:wxmsw29ud_adv",
			"/NODEFAULTLIB:wxmsw29d_adv",
			"/NODEFAULTLIB:wxmsw29u_adv",
			"/NODEFAULTLIB:wxmsw29_adv",
			"/NODEFAULTLIB:wxmsw29ud_html",
			"/NODEFAULTLIB:wxmsw29d_html",
			"/NODEFAULTLIB:wxmsw29u_html",
			"/NODEFAULTLIB:wxmsw29_html",
			"/NODEFAULTLIB:wxmsw29ud_qa",
			"/NODEFAULTLIB:wxmsw29d_qa",
			"/NODEFAULTLIB:wxmsw29u_qa",
			"/NODEFAULTLIB:wxmsw29_qa",
			"/NODEFAULTLIB:wxmsw29ud_xrc",
			"/NODEFAULTLIB:wxmsw29d_xrc",
			"/NODEFAULTLIB:wxmsw29u_xrc",
			"/NODEFAULTLIB:wxmsw29_xrc",
			"/NODEFAULTLIB:wxmsw29ud_aui",
			"/NODEFAULTLIB:wxmsw29d_aui",
			"/NODEFAULTLIB:wxmsw29u_aui",
			"/NODEFAULTLIB:wxmsw29_aui",
			"/NODEFAULTLIB:wxmsw29ud_propgrid",
			"/NODEFAULTLIB:wxmsw29d_propgrid",
			"/NODEFAULTLIB:wxmsw29u_propgrid",
			"/NODEFAULTLIB:wxmsw29_propgrid",
			"/NODEFAULTLIB:wxmsw29ud_ribbon",
			"/NODEFAULTLIB:wxmsw29d_ribbon",
			"/NODEFAULTLIB:wxmsw29u_ribbon",
			"/NODEFAULTLIB:wxmsw29_ribbon",
			"/NODEFAULTLIB:wxmsw29ud_richtext",
			"/NODEFAULTLIB:wxmsw29d_richtext",
			"/NODEFAULTLIB:wxmsw29u_richtext",
			"/NODEFAULTLIB:wxmsw29_richtext",
			"/NODEFAULTLIB:wxmsw29ud_media",
			"/NODEFAULTLIB:wxmsw29d_media",
			"/NODEFAULTLIB:wxmsw29u_media",
			"/NODEFAULTLIB:wxmsw29_media",
			"/NODEFAULTLIB:wxmsw29ud_stc",
			"/NODEFAULTLIB:wxmsw29d_stc",
			"/NODEFAULTLIB:wxmsw29u_stc",
			"/NODEFAULTLIB:wxmsw29_stc",
			"/NODEFAULTLIB:wxmsw29ud_gl",
			"/NODEFAULTLIB:wxmsw29d_gl",
			"/NODEFAULTLIB:wxmsw29u_gl",
			"/NODEFAULTLIB:wxmsw29_gl",
		}

	project "Platform"
		kind "SharedLib"
		language "C++"
		defines
		{
			"PLATFORM_EXPORTS",
		}
		files
		{
			"Platform/*.h",
			"Platform/*.cpp",
		}

		configuration "windows"
			files
			{
				"Platform/Windows/*.h",
				"Platform/Windows/*.cpp",
			}
			links
			{
				"ws2_32",
			}
		configuration "macosx"
			files
			{
				"Platform/POSIX/*.h",
				"Platform/POSIX/*.cpp",
			}
		configuration "linux"
			files
			{
				"Platform/POSIX/*.h",
				"Platform/POSIX/*.cpp",
			}

	project "Foundation"
		kind "SharedLib"
		language "C++"
		defines
		{
			"FOUNDATION_EXPORTS",
		}
		includedirs
		{
			"Dependencies/Expat",
			"Dependencies/zlib",
		}
		files
		{
			"Foundation/**.h",
			"Foundation/**.cpp",
		}
		links
		{
			"Platform",
			"ws2_32",
			"Expat",
			"zlib",
		}

	project "Pipeline"
		kind "SharedLib"
		language "C++"
		defines
		{
			"PIPELINE_EXPORTS",
		}
		includedirs
		{
			"Dependencies/squish",
			"Dependencies/nvtt",
			"Dependencies/nvtt/src",
			"Dependencies/tiff",
			"Dependencies/tiff/libtiff",
		}
		files
		{
			"Pipeline/**.h",
			"Pipeline/**.cpp",
		}
		links
		{
			"Platform",
			"Foundation",
			"squish",
			"nvtt",
			"tiff",
		}

		configuration "windows"
			includedirs
			{
				"Dependencies/nvtt/project/vc8",
			}

	project "Core"
		kind "SharedLib"
		language "C++"
		defines
		{
			"CORE_EXPORTS",
		}
		files
		{
			"Core/**.h",
			"Core/**.cpp",
		}
		links
		{
			"Foundation",
			"Platform",
			"opengl32",
			"glu32",
			"d3d9",
			"d3dx9",
		}	

		configuration "windows"
			includedirs
			{
				os.getenv( "DXSDK_DIR" ) .. "/include",
			}
		configuration { "windows", "x32" }
			libdirs
			{
				os.getenv( "DXSDK_DIR" ) .. "/lib/x86",
			}
		configuration { "windows", "x64" }
			libdirs
			{
				os.getenv( "DXSDK_DIR" ) .. "/lib/x64",
			}

	project "Editor"
		kind "ConsoleApp"
		language "C++"
		files
		{
			"Editor/**.h",
			"Editor/**.c",
			"Editor/**.cpp",
		}
		includedirs
		{
			"Editor",
			"Dependencies/wxWidgets/include",
			"Dependencies/litesql/include",
			"Dependencies/p4api/include",
			"Dependencies/lua/src",
		}
		links
		{
			"Platform",
			"Foundation",
			"Pipeline",
			"Core",
			"litesql",
			"libclient",
			"librpc",
			"libsupp",
			"lua",
			"d3d9",
			"d3dx9",
			"ws2_32",
		}

		configuration "windows"
			includedirs
			{
				"Dependencies/wxWidgets/include/msvc",
				os.getenv( "DXSDK_DIR" ) .. "/include",
			}
			postbuildcommands
			{
				"robocopy /MIR /MT \"..\\Editor\\Icons\\Helium\" \"$(OutDir)\\Icons\"",
				"exit /B 0",
			}			
			
		-- per architecture
		configuration { "windows", "x32" }
			libdirs
			{
				"Dependencies/wxWidgets/lib/vc_dll",
				os.getenv( "DXSDK_DIR" ) .. "/lib/x86",
			}
		configuration { "windows", "x64" }
			libdirs
			{
				"Dependencies/wxWidgets/lib/vc_amd64_dll",
				os.getenv( "DXSDK_DIR" ) .. "/lib/x64"
			}
			
		-- per configuration
		configuration { "windows", "Debug" }
			links
			{
				"wxmsw29d"
			}
		configuration { "windows", "Release" }
			links
			{
				"wxmsw29"
			}
		configuration { "windows", "DebugUnicode" }
			links
			{
				"wxmsw29ud"
			}
		configuration { "windows", "ReleaseUnicode" }
			links
			{
				"wxmsw29u"
			}
			
		-- per architecture, per configuration
		configuration { "windows", "x32", "Debug*" }
			libdirs
			{
				"Dependencies/p4api/lib/Win32/Debug",
			}
		configuration { "windows", "x32", "Release*" }
			libdirs
			{
				"Dependencies/p4api/lib/Win32/Release",
			}
		configuration { "windows", "x64", "Debug*" }
			libdirs
			{
				"Dependencies/p4api/lib/x64/Debug",
			}
		configuration { "windows", "x64", "Release*" }
			libdirs
			{
				"Dependencies/p4api/lib/x64/Release",
			}