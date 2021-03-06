//----------------------------------------------------------------------------------------------------------------------
// CacheObjectLoader.h
//
// Copyright (C) 2010 WhiteMoon Dreams, Inc.
// All Rights Reserved
//----------------------------------------------------------------------------------------------------------------------

#pragma once
#ifndef HELIUM_ENGINE_CACHE_OBJECT_LOADER_H
#define HELIUM_ENGINE_CACHE_OBJECT_LOADER_H

#include "Engine/GameObjectLoader.h"

namespace Helium
{
    class CachePackageLoader;

    /// GameObject loader for loading objects from binary cached data.
    class HELIUM_ENGINE_API CacheObjectLoader : public GameObjectLoader
    {
    public:
        /// @name Construction/Destruction
        //@{
        CacheObjectLoader();
        virtual ~CacheObjectLoader();
        //@}

        /// @name Static Initialization
        //@{
        static bool InitializeStaticInstance();
        //@}

    protected:
        /// Package loader (currently only one, may support multiple later).
        CachePackageLoader* m_pPackageLoader;

        /// @name Loading Implementation
        //@{
        virtual PackageLoader* GetPackageLoader( GameObjectPath path );
        virtual void TickPackageLoaders();
        //@}
    };
}

#endif  // HELIUM_ENGINE_CACHE_OBJECT_LOADER_H
