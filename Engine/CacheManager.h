//----------------------------------------------------------------------------------------------------------------------
// CacheManager.h
//
// Copyright (C) 2010 WhiteMoon Dreams, Inc.
// All Rights Reserved
//----------------------------------------------------------------------------------------------------------------------

#pragma once
#ifndef HELIUM_ENGINE_CACHE_MANAGER_H
#define HELIUM_ENGINE_CACHE_MANAGER_H

#include "Engine/Cache.h"

#include "Foundation/File/Path.h"

/// Cache table of contents file extension.
#define HELIUM_CACHE_TOC_EXTENSION TXT( "cachetoc" )
/// Cache file extension.
#define HELIUM_CACHE_EXTENSION TXT( "cache" )

namespace Helium
{
    /// Manager for object and resource serialization caches.
    class HELIUM_ENGINE_API CacheManager : NonCopyable
    {
    public:
        /// Number of cache objects per cache pool block.
        static const size_t CACHE_POOL_BLOCK_SIZE = 4;

        /// @name Cache Access
        //@{
        Cache* GetCache( Name name, Cache::EPlatform platform = Cache::PLATFORM_INVALID );
        //@}

        /// @name Filesystem Information
        //@{
        const String& GetPlatformDataDirectory( Cache::EPlatform platform = Cache::PLATFORM_INVALID );
        //@}

        /// @name Static Access
        //@{
        static bool InitializeStaticInstance( const Path& rBaseDirectory );
        static CacheManager& GetStaticInstance();
        static void DestroyStaticInstance();
        //@}

        /// @name Platform Information
        //@{
        Cache::EPlatform GetCurrentPlatform();
        //@}

    private:
        /// Platform cache data directories.
        String m_platformDataDirectories[ Cache::PLATFORM_MAX ];

        /// Cache object pool.
        ObjectPool< Cache > m_cachePool;
        /// Cache lookup tables.
        ConcurrentHashMap< Name, Cache* > m_cacheMaps[ Cache::PLATFORM_MAX ];

        /// Singleton instance.
        static CacheManager* sm_pInstance;

        /// @name Construction/Destruction
        //@{
        CacheManager( const Path& rBaseDirectory );
        ~CacheManager();
        //@}
    };
}

#endif  // HELIUM_ENGINE_CACHE_MANAGER_H
