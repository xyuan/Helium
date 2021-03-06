#pragma once

#include "Platform/API.h"

#include <string>
#include <iostream>
#include <strstream>

#include "Platform/Types.h"
#include "Platform/Exception.h"

namespace Helium
{
    //
    // Environment variable access
    //

    template<class T>
    inline bool GetEnvironmentVariable( const tstring& variableName, T& value )
    {
        tchar_t* stringValue;
        size_t requiredSize;

        _tgetenv_s( &requiredSize, NULL, 0, variableName.c_str() );

        if ( requiredSize == 0 )
        {
            return false;
        }

        stringValue = (tchar_t*) malloc( requiredSize * sizeof( tchar_t ) );
        if ( !stringValue )
        {
            throw Helium::Exception( TXT( "Out of memory" ) );
        }

        _tgetenv_s( &requiredSize, stringValue, requiredSize, variableName.c_str() );

        tstringstream str ( stringValue );
        str >> value;
        bool result = !str.fail();

        free( stringValue );
        
        return result;
    }

    template<>
    inline bool GetEnvironmentVariable( const tstring& variableName, bool& value )
    {
        tstring stringValue;
        if ( GetEnvironmentVariable( variableName, stringValue ) )
        {
            if ( !_tcsicmp( stringValue.c_str(), TXT( "false" ) ) || !_tcsicmp( stringValue.c_str(), TXT( "0" ) ) )
            {
                value = false;
                return true;
            }

            if ( !_tcsicmp( stringValue.c_str(), TXT( "true" ) ) || !_tcsicmp( stringValue.c_str(), TXT( "1" ) ) )
            {
                value = true;
                return true;
            }
        }

        return false;
    }

    HELIUM_PLATFORM_API bool GetUsername( tstring& username );

    // this one is not named very well, but it's to avoid conflicts on windows with GetComputerName defines
    HELIUM_PLATFORM_API bool GetComputer( tstring& computername );

    HELIUM_PLATFORM_API bool GetPreferencesDirectory( tstring& preferencesDirectory );
    HELIUM_PLATFORM_API bool GetGameDataDirectory( tstring& gameDataDirectory );
}